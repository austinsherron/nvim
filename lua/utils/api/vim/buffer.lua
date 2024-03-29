local Lambda = require 'toolbox.functional.lambda'
local Path = require 'toolbox.system.path'
local Set = require 'toolbox.extensions.set'

local enum = require('toolbox.extensions.enum').enum

local LOGGER = GetLogger 'VIEW'
local RESTORABLE_BUF_TYPES = Set.of('help', 'terminal')

--- Specifies how to view/open a buffer.
---
---@enum ViewMode
local ViewMode = enum({
  -- open buffer in vertical split (side-by-side)
  VSPLIT = { i = 1, key = 'vsplit', label = 'vsplit', binding = 'v' },
  -- open buffer in split (over-under)
  SPLIT = { i = 2, key = 'split', label = 'split', binding = 'h' },
  -- open standalone buffer
  STANDALONE = { i = 3, key = 'e', label = 'buffer', binding = 'f' },
}, 'STANDALONE')

--- Buffer option keys (names). See :h help-buffer-options.
---
---@enum OptionKey
local OptionKey = enum({
  FILETYPE = 'filetype',
  HIDDEN = 'bufhidden',
  MODIFIABLE = 'modifiable',
  TYPE = 'buftype',
})

--- Parameterizes buffer queries.
---
---@class BufferQuery<S, T>
---@field filter (fun(bufnr: integer): boolean)|false|nil: filter value passed to
--- Buffer.getall
---@field query (fun(bufnr: integer): boolean)|false|nil: query filter applied after
--- above filter
---@field xfm (fun(bufnr: integer): `T`): optional, defaults to Buffer.info; buffer
--- transform applied to results
---@field collector (fun(b: `T[]`): `S`): optional buffer collector applied to results

--- Models a buffer option w/ a value.
---
---@class BufferOption
---@field key OptionKey: the option key/name
---@field value any: the option value

--- Contains information about a buffer.
---
---@class BufferInfo
---@field id integer: the buffer's id
---@field name string: the buffer's name (its path)
---@field filename string: the buffer's filename (parent dir removed)
---@field type string: the value of the buffer's type option
---@field filetype string: the buffer's filetype
local BufferInfo = {}
BufferInfo.__index = BufferInfo

--- Constructor
---
---@note: See class docs for param descriptions.
---
---@return BufferInfo: a new instance
function BufferInfo.new(bufnr, name, type, filetype)
  return setmetatable({
    id = bufnr,
    name = name,
    filename = Path.basename(name),
    type = type,
    filetype = filetype,
  }, BufferInfo)
end

---@return string: a string representation of this instance
function BufferInfo:__tostring()
  return fmt(
    'Buffer(id=%s, name=%s, type=%s, filetype=%s)',
    self.id,
    self.name,
    self.type,
    self.filetype
  )
end

--- Contains utilities for interacting w/ (n)vim buffers.
---
---@class Buffer
local Buffer = {}

---@return integer: the id of the current buffer, i.e.: where the cursor is
function Buffer.current()
  return vim.api.nvim_get_current_buf()
end

--- Gets the name of the buffer w/ id == bufnr.
---
---@param bufnr integer|nil: optional, defaults to current buffer; the id of the buffer
---@return string: the name of the buffer w/ id == bufnr, or the empty string ('') if it
--- doesn't exist
function Buffer.getname(bufnr)
  bufnr = bufnr or Buffer.current()
  return vim.api.nvim_buf_get_name(bufnr)
end

--- Checks if the buffer w/ id == bufnr has a name.
---
---@param bufnr integer|nil: optional, defaults to current buffer; the id of the buffer
--- to check
---@return boolean: true if the buffer w/ id == bufnr has a name, false otherwise
function Buffer.hasname(bufnr)
  bufnr = bufnr or Buffer.current()
  return String.not_nil_or_empty(Buffer.getname(bufnr))
end

--- Checks if a buffer is "normal" (i.e.: has no "type" option).
---
---@param bufopts { id: integer|nil, type: string|nil }: a table that contains either the
--- id or the type of the buffer to check
---@return boolean: true if the buffer is normal, false otherwise
function Buffer.is_normal(bufopts)
  bufopts = bufopts or { id = Buffer.current() }

  local buftype = bufopts.type or Buffer.getoption(bufopts.id, OptionKey.TYPE)
  return String.nil_or_empty(buftype)
end

--- Checks if a buffer is listed.
---
---@see vim.fn.buflisted
---@param bufnr integer|nil: optional, defaults to current buffer; the number of the
--- buffer to check
---@return boolean: true if the buffer w/ id bufnr is listed, false otherwise
function Buffer.is_listed(bufnr)
  bufnr = bufnr or Buffer.current()
  return vim.fn.buflisted(bufnr) == 1
end

--- Gets the option value for a buffer, if it exists.
---
---@see vim.api.nvim_buf_get_option
---
---@param bufnr integer|nil: optional, defaults to current buffer; the id of the buffer
--- for which to retrieve an option
---@param option OptionKey: the option to retrieve
---@return any|nil: the value of the option for buffer bufnr, if any
function Buffer.getoption(bufnr, option)
  bufnr = bufnr or Buffer.current()
  option = vim.api.nvim_buf_get_option(bufnr, tostring(option))

  if option ~= nil then
    return option
  end

  -- fall back to if the prior option retrieval method yields no value
  return vim.api.nvim_get_option_value(option, { buffer = bufnr })
end

--- Checks if a buffer is restorable, i.e.: via a session.
---
---@note: Adapted from a similar function implemented in neovim-session-manager:
---       https://github.com/Shatur/neovim-session-manager/blob/master/lua/session_manager/utils.lua#L128
---
---@param bufnr integer|nil: optional, defaults to current buffer; the id of the buffer to
--- check
---@return boolean: true if the buffer is can be restored, false otherwise
function Buffer.is_restorable(bufnr)
  bufnr = bufnr or Buffer.current()

  local buftype = Buffer.getoption(bufnr, OptionKey.TYPE)
  local is_normal = Buffer.is_normal({ type = buftype })

  if not is_normal then
    return RESTORABLE_BUF_TYPES:contains(buftype)
  end

  return Buffer.is_listed(bufnr) and Buffer.hasname(bufnr)
end

--- Gets a BufferInfo for the provided bufnr.
---
---@param bufnr integer|nil: optional, defaults to current buffer; the id of the buffer
--- for which to get info
---@return BufferInfo: buffer info for the provided bufnr
function Buffer.info(bufnr)
  bufnr = bufnr or Buffer.current()

  return BufferInfo.new(
    bufnr,
    Buffer.getname(bufnr),
    Buffer.getoption(bufnr, OptionKey.TYPE),
    Buffer.getoption(bufnr, OptionKey.FILETYPE)
  )
end

local function get_buffer_filters(filter)
  if filter ~= false and (filter ~= nil and type(filter) ~= 'function') then
    Err.raise('Buffer.getall: unrecognized filter=%s', filter)
  end

  local default = ternary(filter == false, function()
    return Lambda.TRUE
  end, function()
    return Buffer.is_listed
  end)

  local optional = ternary(type(filter) == 'function', function()
    return filter
  end, function()
    return Lambda.TRUE
  end)

  return default, optional
end

--- Gets listed (i.e.: open/visible) buffer ids.
---
---@see vim.api.nvim_list_bufs()
---@generic T
---@param filter (fun(bufnr: integer): boolean)|false|nil: optional; filters buffer ids;
--- if false, uses non filter and returns all buffers (i.e.: possible hidden, unlisted,
--- etc.)
---@param xfm (fun(bufnr: integer): T)|nil optional; transforms buffer ids
---@return T[]: current buffer handles, or buffer handles transformed by xfm, if provided
function Buffer.getall(filter, xfm)
  xfm = xfm or Lambda.IDENTITY

  local def_filter, opt_filter = get_buffer_filters(filter)

  return Stream.new(vim.api.nvim_list_bufs())
    :filter(def_filter)
    :filter(opt_filter)
    :map(xfm)
    :collect()
end

--- Perform a buffer query according to opts.
---
---@generic T
---@param opts BufferQuery|nil: parameterizes buffer query
---@return T|nil: zero or more buffers queried using opts
function Buffer.query(opts)
  opts = opts or {}

  local query = opts.query or Lambda.TRUE
  local xfm = opts.xfm or Buffer.info

  return Stream.new(Buffer.getall(opts.filter))
    :map(xfm)
    :filter(query)
    :collect(opts.collector)
end

--- Sets option values on a buffer.
---
---@param opts { bufnr: integer|nil, options: BufferOption[] }: contains the options to
--- set; optionally sets the options on buffer == opts.bufnr, or the current buffer if not
--- included
function Buffer.setoptions(opts)
  local bufnr = opts.bufnr or Buffer.current()

  for _, option in ipairs(opts.options) do
    vim.api.nvim_buf_set_option(bufnr, tostring(option.key), option.value)
  end
end

--- Opens a buffer, either transient w/ no file, or for the file at path, if provided.
---
---@param viewmode ViewMode|nil: optional, defaults to ViewMode.STANDALONE at the time of
--- writing; "how" to open the buffer
---@param path string|nil: optional; the path to the file to open, if any
---@param options BufferOption[]|nil: optional; options to set on the opened buffer
function Buffer.open(viewmode, path, options)
  LOGGER:debug('Buffer.open: viewmode=%s, path=%s', { viewmode, path })

  viewmode = ViewMode:or_default(viewmode)
  options = options or {}

  ---@diagnostic disable-next-line: need-check-nil, undefined-field
  vim.cmd[viewmode.key](path)

  Buffer.setoptions({ options = options })
end

--- Closes the buffer w/ id bufnr.
---
---@param bufnr integer: the id of the buffer to close
---@param force boolean|nil: optional, defaults to false; if true, buffers w/ unsaved
--- changes will be closed
function Buffer.close(bufnr, force)
  force = Bool.or_default(force, false)

  local bangornot = ternary(force, '!', '')
  local cmd = fmt('silent bd%s %s', bangornot, bufnr)

  LOGGER:debug('Buffer.close: %s', { cmd })
  vim.cmd(cmd)
end

--- Closes all listed (i.e.: open/visible) buffers.
---
---@param force boolean|nil: optional, defaults to false; if true, buffers w/ unsaved
--- changed will be closed
function Buffer.closeall(force)
  local bufnrs = Buffer.getall()
  LOGGER:debug('Buffer.closeall: closing buffers=%s', { bufnrs })

  for _, bufnr in ipairs(bufnrs) do
    Buffer.close(bufnr, force)
  end
end

---@note: so ViewMode is publicly accessible
Buffer.ViewMode = ViewMode
---@note: so OptionKey is publicly accessible
Buffer.OptionKey = OptionKey
---@note: so BufferInfo is publicly accessible
Buffer.BufferInfo = BufferInfo

return Buffer

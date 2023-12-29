local Set    = require 'toolbox.extensions.set'
local Lambda = require 'toolbox.functional.lambda'

local enum = require('toolbox.extensions.enum').enum


local RESTORABLE_BUF_TYPES = Set.of('help', 'terminal')

--- Specifies how to view/open a buffer.
---
---@enum ViewMode
local ViewMode = enum({
  STANDALONE = 'e',         -- open standalone buffer
  SPLIT      = 'split',     -- open buffer in split (over-under)
  VSPLIT     = 'vsplit',    -- open buffer in vertical split (side-by-side)
}, 'STANDALONE')

--- Buffer options. See :h help-buffer-options.
---
---@enum Option
local Option = enum({
  HIDDEN = 'bufhidden',
  TYPE   = 'buftype',
})

--- Contains information about a buffer.
---
---@class BufferInfo
---@field id integer: the buffer's id
---@field name string: the buffer's name
---@field type string: the value of the buffer's type option
local BufferInfo = {}
BufferInfo.__index = BufferInfo

--- Constructor
---
---@note: See class docs for param descriptions.
---
---@return BufferInfo: a new instance
function BufferInfo.new(bufnr, name, type)
  return setmetatable({
    id   = bufnr,
    name = name,
    type = type,
  }, BufferInfo)
end


---@return string: a string representation of this instance
function BufferInfo:__tostring()
  return fmt(
    'Buffer(id=%s, name=%s, type=%s)',
    self.id, self.name, self.type
  )
end

--- Contains utilities for interacting w/ (n)vim buffers.
---
---@class Buffer
local Buffer = {}

--- Gets the name of the buffer w/ id == bufnr.
---
---@param bufnr integer: the id of the buffer
---@return string: the name of the buffer w/ id == bufnr, or the empty string ('') if it
--- doesn't exist
function Buffer.getname(bufnr)
  return vim.api.nvim_buf_get_name(bufnr)
end


--- Checks if the buffer w/ id == bufnr has a name.
---
---@param bufnr integer: the id of the buffer to check
---@return boolean: true if the buffer w/ id == bufnr has a name, false otherwise
function Buffer.hasname(bufnr)
  return String.not_nil_or_empty(Buffer.getname(bufnr))
end


--- Checks if a buffer is "normal" (i.e.: has no "type" option).
---
---@param bufopts { id: integer|nil, type: string|nil }: a table that contains either the
--- id or the type of the buffer to check
---@return boolean: true if the buffer is normal, false otherwise
function Buffer.is_normal(bufopts)
  local buftype = bufopts.type or Buffer.getoption(bufopts.id, Option.TYPE)
  return String.nil_or_empty(buftype)
end


--- Checks if a buffer is listed.
---
---@see vim.fn.buflisted
---@param bufnr integer: the number of the buffer to check
---@return boolean: true if the buffer w/ id bufnr is listed, false otherwise
function Buffer.is_listed(bufnr)
  return vim.fn.buflisted(bufnr) == 1
end


--- Gets the option value for a buffer, if it exists.
---
---@see vim.api.nvim_buf_get_option
---
---@param bufnr integer: the id of the buffer for which to retrieve an option
---@param option Option: the option to retrieve
---@return any|nil: the value of the option for buffer bufnr, if any
function Buffer.getoption(bufnr, option)
  return vim.api.nvim_buf_get_option(bufnr, tostring(option))
end


--- Checks if a buffer is restorable, i.e.: via a session.
---
---@note: Adapted from a similar function implemented in neovim-session-manager:
---       https://github.com/Shatur/neovim-session-manager/blob/master/lua/session_manager/utils.lua#L128
---
---@param bufnr integer: the id of the buffer to check
---@return boolean: true if the buffer is can be restored, false otherwise
function Buffer.is_restorable(bufnr)
  local buftype = Buffer.getoption(bufnr, Option.TYPE)
  local is_normal = Buffer.is_normal({ type = buftype })

  if not is_normal then
    return RESTORABLE_BUF_TYPES:contains(buftype)
  end

  return Buffer.is_listed(bufnr) and Buffer.hasname(bufnr)
end


--- Gets a BufferInfo for the provided bufnr.
---
---@param bufnr integer: the if of the buffer for which to get info
---@return BufferInfo: buffer info for the provided bufnr
function Buffer.info(bufnr)
  return BufferInfo.new(
    bufnr,
    Buffer.getname(bufnr),
    Buffer.getoption(bufnr, Option.TYPE)
  )
end


--- Gets listed (i.e.: open/visible) buffer ids.
---
---@see vim.api.nvim_list_bufs()
---@generic T
---@param filter (fun(bufnr: integer): boolean)|nil optional; filters buffer ids
---@param xfm (fun(bufnr: integer): T)|nil optional; transforms buffer ids
---@return T[]: current buffer handles, or buffer handles transformed by xfm, if provided
function Buffer.getall(filter, xfm)
  filter = filter or Lambda.IDENTITY
  xfm = xfm or Lambda.IDENTITY

  return Stream.new(vim.api.nvim_list_bufs())
    :filter(Buffer.is_listed)
    :filter(filter)
    :map(xfm)
    :collect()
end


--- Gets a buffer option value.
--- Opens an empty standalone buffer.
function Buffer.blank()
  vim.cmd('enew')
end


--- Opens a buffer, either transient w/ no file, or for the file at path, if provided.
---
---@param view_mode string|nil: optional, defaults to ViewMode.STANDALONE at the time of
--- writing; "how" to open the buffer
---@param path string|nil: optional; the path to the file to open, if any
function Buffer.open(view_mode, path)
  Debug('Buffer.open: %s %s', { view_mode, path })

  view_mode = ViewMode:or_default(view_mode)
  vim.cmd[view_mode](path)
end


--- Closes the buffer w/ id bufnr.
---
---@param bufnr integer: the id of the buffer to close
---@param force boolean|nil: optional, defaults to false; if true, buffers w/ unsaved
--- changed will be closed
function Buffer.close(bufnr, force)
  force = Bool.or_default(force, false)

  local bangornot = ternary(force, '!', '')
  local cmd = fmt('silent bd%s %s', bangornot, bufnr)

  Debug('Buffer.close: %s', { cmd })
  vim.cmd(cmd)
end


--- Closes all listed (i.e.: open/visible) buffers.
---
---@param force boolean|nil: optional, defaults to false; if true, buffers w/ unsaved
--- changed will be closed
function Buffer.closeall(force)
  local bufnrs = Buffer.getall()
  Debug('Buffer.closeall: closing buffers=%s', { bufnrs })

  for _, bufnr in ipairs(bufnrs) do
    Buffer.close(bufnr, force)
  end
end

---@note: so ViewMode is publicly accessible
Buffer.ViewMode = ViewMode
---@note: so Option is publicly accessible
Buffer.Option = Option
---@note: so BufferInfo is publicly accessible
Buffer.BufferInfo = BufferInfo

return Buffer


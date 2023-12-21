local Stream = require 'toolbox.extensions.stream'

local enum = require('toolbox.extensions.enum').enum


--- Specifies how to view/open a buffer.
---
---@enum ViewMode
local ViewMode = enum({
  STANDALONE = 'e',         -- open standalone buffer
  SPLIT      = 'split',     -- open buffer in split (over-under)
  VSPLIT     = 'vsplit',    -- open buffer in vertical split (side-by-side)
}, 'STANDALONE')

--- Contains utilities for interacting w/ (n)vim buffers.
---
---@class Buffer
local Buffer = {}

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
  view_mode = ViewMode:or_default(view_mode)
  vim.cmd[view_mode](path)
end


--- Checks if a buffer is listed.
---
---@see vim.fn.buflisted
---@param bufnr integer: the number of the buffer to check
---@return boolean: true if the buffer w/ id bufnr is listed, false otherwise
function Buffer.is_listed(bufnr)
  return vim.fn.buflisted(bufnr) == 1
end


--- Gets listed (i.e.: open/visible) buffer ids.
---
---@see vim.api.nvim_list_bufs()
---@return integer[]: current buffer handles
function Buffer.getall()
  return Stream.new(vim.api.nvim_list_bufs())
    :filter(Buffer.is_listed)
    :collect()
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

  vim.cmd(cmd)
end


--- Closes all listed (i.e.: open/visible) buffers.
---
---@param force boolean|nil: optional, defaults to false; if true, buffers w/ unsaved
--- changed will be closed
function Buffer.closeall(force)
  local bufnrs = Buffer.getall()

  for _, bufnr in ipairs(bufnrs) do
    Buffer.close(bufnr, force)
  end
end

---@note: so ViewMode is publicly accessible
Buffer.ViewMode = ViewMode

return Buffer


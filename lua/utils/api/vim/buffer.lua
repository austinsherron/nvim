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


---@see vim.api.nvim_list_bufs
---@return any[]: current buffer handles
function Buffer.getall()
  return vim.api.nvim_list_bufs()
end

---@note: so ViewMode is publicly accessible
Buffer.ViewMode = ViewMode

return Buffer


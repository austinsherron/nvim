local Buffer = require 'utils.api.vim.buffer'


--- Contains utilities for interacting w/ (n)vim windows.
---
---@class Window
local Window = {}

---@return integer: the id of the current window, i.e.: where the cursor is
function Window.current()
  return vim.api.nvim_get_current_win()
end


--- Gets the buffer's current window id.
---
---@param bufnr integer|nil: optional, defaults to current buffer; the buffer for which to
--- get a window id
---@return integer: the buffer's current window id
function Window.frombuf(bufnr)
  bufnr = bufnr or Buffer.current()
  return vim.fn.bufwinnr(bufnr)
end


--- Closes the window w/ id winnr.
---
---@param winnr integer: the id of the window to close
---@param force boolean|nil: optional, defaults to false; if true, windows w/ unsaved
--- changes will be closed
function Window.close(winnr, force)
  winnr = winnr or Window.current()
  force = Bool.or_default(force, false)

  vim.api.nvim_win_close(winnr, force)
end

return Window


local Buffer = require 'utils.api.vim.buffer'

local enum = require('toolbox.extensions.enum').enum

local smart_splits = Lazy.require 'smart-splits'

--- Contains utilities for interacting w/ (n)vim windows.
---
---@class Window
local Window = {}

--- Directions in which a window can be resized, swapped, etc..
---
---@enum WindowOpDirection
local WindowOpDirection = enum({
  LEFT = 'left',
  RIGHT = 'right',
  UP = 'up',
  DOWN = 'down',
})

--- Contains info about a window and the buffer it displays.
---
---@class WindowBuffer
---@field id integer: the window's id
---@field buffer BufferInfo: info about the buffer the window displays
local WindowBuffer = {}
WindowBuffer.__index = WindowBuffer

--- Constructor
---
---@param id integer|nil: optional, defaults to current window; see field docstring for
--- info
---@return WindowBuffer: a new instance
function WindowBuffer.new(id)
  id = id or Window.current()

  return setmetatable({
    id = id,
    buffer = Buffer.info(Window.tobuf(id)),
  }, WindowBuffer)
end

---@note: so WindowOpDirection is publicly exposed
Window.WindowOpDirection = WindowOpDirection
---@note: so WindowBuffer is publicly exposed
Window.WindowBuffer = WindowBuffer

---@return integer: the id of the current window, i.e.: where the cursor is
function Window.current()
  return vim.api.nvim_get_current_win()
end

--- Gets the window's buffer id.
---
---@param winnr integer|nil: optional, defaults to current window; the window for which to
--- get a buffer id
---@return integer: the buffer's current window id
function Window.tobuf(winnr)
  winnr = winnr or Window.current()
  return vim.api.nvim_win_get_buf(winnr)
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

--- Gets a WindowBuffer for the provided winnr.
---
---@param winnr integer|nil: optional, defaults to current window; the id of the window
--- for which to get info
---@return WindowBuffer: window buffer for the provided winnr
function Window.buffer(winnr)
  winnr = winnr or Window.current()
  return WindowBuffer.new(winnr)
end

--- Closes the window w/ id winnr.
---
---@param winnr integer|nil: optional, defaults to the current window; the id of the
--- window to close
---@param force boolean|nil: optional, defaults to false; if true, windows w/ unsaved
--- changes will be closed
function Window.close(winnr, force)
  winnr = winnr or Window.current()
  force = Bool.or_default(force, false)

  vim.api.nvim_win_close(winnr, force)
end

--- Resizes the current window in a direction.
---
---@param direction WindowOpDirection: the direction in which to resize a window
function Window.resize(direction)
  smart_splits['resize_' .. direction]()
end

--- Swaps the current buffer to another window in a direction. The cursor follows the
--- window unless hold_cursor == true.
---
---@param direction WindowOpDirection: the direction of the window to which to swap the
--- current buffer
---@param hold_cursor boolean|nil: optional, defaults to false; if true, the cursor won't
--- follow the swapped window
function Window.swap(direction, hold_cursor)
  smart_splits['swap_buf_' .. direction]({ move_cursor = not hold_cursor })
end

return Window

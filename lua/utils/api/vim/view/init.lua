local Buffer = require 'utils.api.vim.buffer'
local Tab    = require 'utils.api.vim.tab'
local Window = require 'utils.api.vim.window'


--- Implements utilities for interacting w/ "views", i.e.: buffers in windows in tabs.
---
---@class View
local View = {}

local function buffer_filter(attrs)
  return function(b)
    for name, val in pairs(attrs) do
      if b[name] ~= val then
        return false
      end
    end

    return true
  end
end


--- Closes a view for buffers w/ BufferInfo props == attrs, in tab w/ id == tabnr.
---
---@param attrs BufferInfo|nil: used to find the view to close by matching buffers to
--- these attrs
---@param tabnr integer|nil: optional, defaults to the current tab; the tab in which to
--- close views
function View.close(attrs, tabnr)
  attrs = attrs or {}
  tabnr = tabnr or Tab.current()

  local winnrs = Tab.windows(tabnr)
  local bufs = Stream.new(winnrs)
    :map(Window.tobuf)
    :map(Buffer.info)
    :filter(buffer_filter(attrs))
    :collect()

  if Table.nil_or_empty(bufs) then
    return
  end

  -- windows close automatically
  Stream.new(bufs)
    :foreach(function(b) Buffer.close(b.id) end)
end

return View


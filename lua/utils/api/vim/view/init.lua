local Buffer = require 'utils.api.vim.buffer'
local Tab = require 'utils.api.vim.tab'
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

local function query_buffers(attrs, tabnr)
  attrs = attrs or {}
  tabnr = tabnr or Tab.current()

  local winnrs = Tab.windows(tabnr)

  return Stream.new(winnrs):map(Window.tobuf):map(Buffer.info):filter(buffer_filter(attrs)):collect()
end

--- Closes a view for buffers w/ BufferInfo props == attrs--or the current buffer if attrs == nil--in tab w/ id == tabnr.
---
---@param attrs BufferInfo|nil: used to find the view to close by matching buffers to
--- these attrs
---@param tabnr integer|nil: optional, defaults to the current tab; the tab in which to
--- close views
function View.close(attrs, tabnr)
  local bufs = ternary(attrs == nil, { Buffer.info() }, function()
    return query_buffers(attrs, tabnr)
  end)

  -- windows close automatically
  foreach(bufs, function(b)
    Buffer.close(b.id)
  end)
end

return View

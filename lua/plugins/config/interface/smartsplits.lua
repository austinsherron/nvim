local Lazy = require 'toolbox.utils.lazy'

local bufresize = Lazy.require 'bufresize' ---@module 'bufresize'

--- Contains functions for configuring the smart-splits plugin.
---
---@class SmartSplits
local SmartSplits = {}

---@return table: a table that contains configuration values for the smart-splits plugin
function SmartSplits.opts()
  return {
    resize_mode = {
      hooks = {
        on_leave = bufresize.register,
      },
    },
  }
end

return SmartSplits


--- Contains functions for configuring the lightbulb plugin.
---
---@class Lightbulb
local Lightbulb = {}

---@return table: a table that contains configuration values for the lightbulb plugin
function Lightbulb.opts()
  return {
    autocmd = {
      enabled = true,
    },
    sign = {
      text = '💡',
    },
  }
end

return Lightbulb


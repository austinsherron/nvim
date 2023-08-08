
--- Contains functions for configuring the fidget plugin.
---
---@class Fidget
local Fidget = {}

---@return table: a table that contains configuration values for the fidget plugin
function Fidget.opts()
  return {
    text = { spinner = 'dots' }
  }
end

return Fidget


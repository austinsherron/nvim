
--- Contains functions for configuring the trouble plugin.
---
---@class Trouble
local Trouble = {}

---@return table: a table that contains configuration values for the trouble plugin
function Trouble.opts()
  return {
    position = 'bottom',
  }
end

return Trouble


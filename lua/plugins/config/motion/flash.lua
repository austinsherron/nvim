--- Contains functions for configuring the flash plugin.
---
---@class Flash
local Flash = {}

---@return table: table that contains configuration values for the flash plugin
function Flash.opts()
  return {
    jump = {
      autojump = true,
    },
    label = {
      rainbow = {
        enabled = true,
        shade = 5,
      },
    },
    highlight = {
      backdrop = true,
    },
    modes = {
      char = {
        enabled = true,
        jump_labels = true,
      },
    },
  }
end

return Flash

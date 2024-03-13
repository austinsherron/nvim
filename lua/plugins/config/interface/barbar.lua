--- Contains functions for configuring barbar.
---
---@class Barbar
local Barbar = {}

---@return table: a table that contains configuration values for the barbar plugin
function Barbar.opts()
  return {
    animation = true,
    clickable = false,
    focus_on_close = 'left',
    no_name_title = 'unnamed',

    icons = {
      diagnostics = {
        enabled = true,
      },
    },
  }
end

return Barbar

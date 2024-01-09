--- Contains functions for configuring the nightfox colorscheme.
---
---@class Nightfox : ColorSchemeConfigurator
local Nightfox = {}

---@return ColorSchemeConfig: a table that contains configuration values for the nightfox
--- colorscheme
function Nightfox.config()
  return {
    pkg = 'nightfox',
    opts = {
      options = {
        modules = {
          alpha = true,
          nvimtree = true,
        },
      },
    },
  }
end

return Nightfox

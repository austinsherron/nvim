--- Contains functions for configuring the tokyonight colorscheme.
---
--- TODO: I'm not 100% sure that this works, but I'm not using this colorscheme at the
--- moment, so I'm not super invested in investigating for now.
---
---@class TokyoNight : ColorSchemeConfigurator
local TokyoNight = {}

---@return ColorSchemeConfig: a table that contains configuration values for the
--- tokyonight colorscheme
function TokyoNight.config()
  return {
    pkg = 'tokyonight',
    opts = {
      style = 'moon',
      styles = {
        comments = { italic = true },
        variables = { bold = true },
        sidebars = 'transparent',
      },
      sidebars = {
        'NvimTree',
        'aerial',
        'DiffviewFiles',
        'spectre_panel',
        'qf',
        'undotree',
      },
    },
  }
end

return TokyoNight

local Interface = require 'utils.api.vim.interface'

local Highlight = Interface.Highlight

local hooks = require 'ibl.hooks'


local HIGHLIGHTS = {
  Highlight.new('RainbowRed'):foreground('#E06C75' ),
  Highlight.new('RainbowYellow'):foreground('#E5C07B' ),
  Highlight.new('RainbowBlue'):foreground('#61AFEF' ),
  Highlight.new('RainbowOrange'):foreground('#D19A66' ),
  Highlight.new('RainbowGreen'):foreground('#98C379' ),
  Highlight.new('RainbowViolet'):foreground('#C678DD' ),
  Highlight.new('RainbowCyan'):foreground('#56B6C2' ),
}

local HIGHLIGHT_NAMES = Table.values(
  HIGHLIGHTS, function(v, _) return v.name end
)

local function set_highlights()
  foreach(HIGHLIGHTS, function(h) Interface.set_highlight(h) end)
end


local function register_highlights()
  hooks.register(hooks.type.HIGHLIGHT_SETUP, set_highlights)
end

--- Contains functions for configuring the indent-blankline plugin.
---
---@class Indent
local Indent = {}

---@return table: a table that contains configuration values for the indent-blankline
--- plugin
function Indent.opts()
  return {
    scope = {
      highlight  = HIGHLIGHT_NAMES,
      show_start = false,
      show_end   = false,
    },
  }
end


--- Configures the indent-blankline plugin.
function Indent.config()
  ---@note: set according to
  ---       https://github.com/lukas-reineke/indent-blankline.nvim#multiple-indent-colors
  register_highlights()

  require('ibl').setup(Indent.opts())
end

return Indent


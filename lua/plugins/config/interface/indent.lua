local Interface = require 'utils.api.vim.interface'

local Colors = Interface.Colors
local Highlight = Interface.Highlight

local hooks = require 'ibl.hooks'

local HIGHLIGHTS = {
  Highlight.new('RainbowRed'):foreground(Colors.RED),
  Highlight.new('RainbowOrange'):foreground(Colors.ORANGE),
  Highlight.new('RainbowYellow'):foreground(Colors.YELLOW),
  Highlight.new('RainbowGreen'):foreground(Colors.GREEN),
  Highlight.new('RainbowBlue'):foreground(Colors.BLUE),
  Highlight.new('RainbowCyan'):foreground(Colors.CYAN),
  Highlight.new('RainbowViolet'):foreground(Colors.VIOLET),
}

local HIGHLIGHT_NAMES = Table.values(HIGHLIGHTS, function(v, _)
  return v.name
end)

local function set_highlights()
  Interface.set_highlights(HIGHLIGHTS)
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
      highlight = HIGHLIGHT_NAMES,
      show_start = false,
      show_end = false,
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

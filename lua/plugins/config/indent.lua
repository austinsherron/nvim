
--- Contains functions for configuring the indent-blankline plugin.
--
---@class Indent
local Indent = {}

---@return table: a table that contains configuration values for the indent-blankline plugin
function Indent.opts()
  return {
    context_char = '┃',
    context_highlight_list = {
      'RainbowDelimiterViolet',
      'RainbowDelimiterBlue',
      'RainbowDelimiterCyan',
      'RainbowDelimiterGreen',
      'RainbowDelimiterYellow',
      'RainbowDelimiterOrange',
      'RainbowDelimiterRed',
    },
    space_char_blankline = ' ',
    show_current_context = true,
    use_treesitter = true,
  }
end

return Indent


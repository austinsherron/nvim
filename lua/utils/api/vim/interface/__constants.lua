local Colors = require 'utils.api.vim.interface.__colors'
local Highlight = require 'utils.api.vim.interface.__highlight'

local DIAGNOSTIC_SIGNS = {
  [vim.diagnostic.severity.ERROR] = '',
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.HINT] = '',
  [vim.diagnostic.severity.INFO] = '',
}

local HIGHLIGHTS = {
  -- INFO: for markdown
  -- NOTE: my current colorscheme, "srcery", doesn't seem to provide markdown hl groups
  Highlight.new('@markup.heading.1.marker'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.2.marker'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.3.marker'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.4.marker'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.5.marker'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.6.marker'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.1'):foreground(Colors.SRCERY_BLUE):bold(),
  Highlight.new('@markup.heading.2'):foreground(Colors.SRCERY_GREEN):bold(),
  Highlight.new('@markup.heading.3'):foreground(Colors.SRCERY_ORANGE),
  Highlight.new('@markup.heading.4'):foreground(Colors.SRCERY_CYAN),
  Highlight.new('@markup.heading.5'):foreground(Colors.SRCERY_BRIGHT_MAGENTA),
  Highlight.new('@markup.heading.6'):foreground(Colors.SRCERY_MAGENTA),
  Highlight.new('@markup.list'):foreground(Colors.SRCERY_ORANGE),
  Highlight.new('@markup.list.checked'):foreground(Colors.SRCERY_CYAN),
  Highlight.new('@markup.list.unchecked'):foreground(Colors.SRCERY_GREEN),
  Highlight.new('@markup.link.label'):foreground(Colors.SRCERY_ORANGE):bold(),
  Highlight.new('@markup.link.url'):foreground(Colors.SRCERY_YELLOW):bold(),
  Highlight.new('@markup.italic'):foreground(Colors.SRCERY_LIGHT_MAGENTA):italic(),
  Highlight.new('@markup.strong'):foreground(Colors.SRCERY_MAGENTA),
  Highlight.new('@markup.raw'):foreground(Colors.BLUE),

  -- for code
  Highlight.new('@comment'):foreground(Colors.BLUE_GREY),
  Highlight.new('@string.documentation.python'):foreground(Colors.GREEN),
  Highlight.new('@variable.parameter.python'):foreground(Colors.SRCERY_YELLOW),
}

return {
  DIAGNOSTIC_SIGNS = DIAGNOSTIC_SIGNS,
  HIGHLIGHTS = HIGHLIGHTS,
}

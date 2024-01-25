local Colors = require 'utils.api.vim.interface.__colors'
local Highlight = require 'utils.api.vim.interface.__highlight'

--- Contains utilities for interacting w/ nvim ui elements.
---
---@class Interface
local Interface = {}

---@note: so Highlight is publicly accessible
Interface.Highlight = Highlight
---@note: so Colors is publicly accessible
Interface.Colors = Colors

--- Sets a highlight group w/ the provided name on the provided buffer.
---
---@param highlight Highlight: the highlight's definition
---@param opts { buf: integer|nil, name: string|nil }|nil: optional; opts include: buf,
--- the id of the buffer on which to set the highlight (defaults to 0, i.e.: global), and
--- name, which acts as a name override for the provided highlight
---
function Interface.set_highlight(highlight, opts)
  opts = opts or {}

  local bufnr = opts.buf or 0
  local name = opts.name or highlight.name

  local hg = highlight:build()
  vim.api.nvim_set_hl(bufnr, name, hg)

  GetLogger('UI'):debug('Highlight=%s created for bufnr=%s; def=%s', { name, bufnr, hg })
end

local DIAGNOSTIC_SIGNS = {
  { name = 'DiagnosticSignError', icon = '' },
  { name = 'DiagnosticSignWarn', icon = '' },
  { name = 'DiagnosticSignHint', icon = '' },
  { name = 'DiagnosticSignInfo', icon = '' },
}

local HIGHLIGHTS = {
  -- NOTE: my current colorscheme, "nightfox", doesn't seem to provide markdown hl groups
  Highlight.new('@markup.heading.1.marker'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.2.marker'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.3.marker'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.4.marker'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.5.marker'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.6.marker'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.1'):foreground(Colors.BLUE),
  Highlight.new('@markup.heading.2'):foreground(Colors.GREEN),
  Highlight.new('@markup.heading.3'):foreground(Colors.BRIGHT_ORANGE),
  Highlight.new('@markup.heading.4'):foreground(Colors.CYAN),
  Highlight.new('@markup.heading.5'):foreground(Colors.VIOLET),
  Highlight.new('@markup.heading.6'):foreground(Colors.VIOLET),
  Highlight.new('@markup.list'):foreground(Colors.ORANGE),
  Highlight.new('@markup.list.checked'):foreground(Colors.CYAN),
  Highlight.new('@markup.list.unchecked'):foreground(Colors.GREEN),
  Highlight.new('@markup.link.label'):foreground(Colors.BRIGHT_ORANGE),
  Highlight.new('@markup.link.url'):foreground(Colors.YELLOW),
  Highlight.new('@markup.italic'):foreground(Colors.VIOLET):italic(),
  Highlight.new('@markup.strong'):foreground(Colors.PURPLE):bold(),
  Highlight.new('@markup.raw'):foreground(Colors.BLUE),
}

--- Registers the provided sign w/ nvim.
---
---@param sign { name: string, icon: string }: the sign to register
function Interface.define_sign(sign)
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.icon, numhl = '' })
end

--- Initializes interface customizations.
function Interface.init()
  -- custom diagnostic signs
  foreach(DIAGNOSTIC_SIGNS, Interface.define_sign)
  -- custom highlights
  foreach(HIGHLIGHTS, function(hl)
    Interface.set_highlight(hl)
  end)
end

return Interface

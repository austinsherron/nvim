local Highlight = require 'utils.api.vim.interface.__highlight'

--- Contains utilities for interacting w/ nvim ui elements.
---
---@class Interface
local Interface = {}

---@note: so Highlight is publicly accessible
Interface.Highlight = Highlight

--- Sets a highlight group w/ the provided name on the provided buffer.
---
---@param highlight Highlight: the highlight's definition
---@param bufnr integer|nil: optional, defaults to 0 (global); the id of the buffer on
--- which to set the highlight
function Interface.set_highlight(highlight, bufnr)
  bufnr = bufnr or 0

  local hg = highlight:build()
  vim.api.nvim_set_hl(bufnr, highlight.name, hg)

  GetLogger('UI'):debug('Highlight=%s created for bufnr=%s; def=%s', { highlight.name, bufnr, hg })
end

local DIAGNOSTIC_SIGNS = {
  { name = 'DiagnosticSignError', icon = '' },
  { name = 'DiagnosticSignWarn', icon = '' },
  { name = 'DiagnosticSignHint', icon = '' },
  { name = 'DiagnosticSignInfo', icon = '' },
}

--- Registers the provided sign w/ nvim.
---
---@param sign { name: string, icon: string }: the sign to register
function Interface.define_sign(sign)
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.icon, numhl = '' })
end

--- Initializes interface customizations.
function Interface.init()
  foreach(DIAGNOSTIC_SIGNS, Interface.define_sign)
end

return Interface

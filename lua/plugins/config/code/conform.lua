local LspLibrary = require 'lsp.library'

--- Configuration for conform.nvim: formatter runner w/ format-on-save and per-filetype
--- dispatch. This is the formatter manifest (analogous to how library.lua LINTERS is the
--- linter manifest for EFM).
---
---@class Conform
local Conform = {}

---@return table: conform.nvim configuration
function Conform.opts()
  return {
    formatters_by_ft = LspLibrary.formatters(),
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    },
  }
end

return Conform

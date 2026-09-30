local Buffer = require 'utils.api.vim.buffer'
local LspLibrary = require 'lsp.library'

local OptionKey = Buffer.OptionKey

--- Filetypes for which format-on-save is disabled. Formatting can still be triggered
--- manually for these filetypes.
local NO_FORMAT_ON_SAVE = Set.of 'yaml'

local FORMAT_ON_SAVE_OPTS = {
  timeout_ms = 3000,
  lsp_format = 'fallback',
}

--- Configuration for conform.nvim: formatter runner w/ format-on-save and per-filetype
--- dispatch. This is the formatter manifest (analogous to how library.lua LINTERS is the
--- linter manifest for EFM).
---
---@class Conform
local Conform = {}

---@param bufnr integer: the buffer being saved
---@return table|nil: format-on-save options, or nil if the buffer's filetype is exempt
--- from format-on-save
local function format_on_save(bufnr)
  local filetype = Buffer.getoption(bufnr, OptionKey.FILETYPE)

  if NO_FORMAT_ON_SAVE:contains(filetype) then
    return nil
  end

  return FORMAT_ON_SAVE_OPTS
end

---@return table: conform.nvim configuration
function Conform.opts()
  return {
    formatters_by_ft = LspLibrary.formatters(),
    format_on_save = format_on_save,
  }
end

return Conform

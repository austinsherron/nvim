local Autocmd = require 'utils.core.autocmd'
local Lsp = require 'utils.api.vim.lsp'
local LspKM = require 'lsp.keymap'

--- Entry point for configuring lsp related autocommands.
---
---@class LspAutocmds
local LspAutocmds = {}

local function bind_keymap(ev)
  LspKM.bind_after_attach(ev.buf)
end

local function doformat(ev)
  if Lsp.isactive('efm', ev.buf) then
    Lsp.format({ name = 'efm' })
  end
end

--- Creates lsp related autocommands.
function LspAutocmds.create()
  GetLogger('AUTOCMD'):info 'Creating lsp autocmds'

  Autocmd.new()
    :withDesc('Binds lsp keymap after an lsp attaches to the relevant buffer')
    :withGroup('UserLspConfig')
    :withEvent('LspAttach')
    :withCallback(bind_keymap)
    :create()

  Autocmd.new()
    :withDesc('Format on save')
    :withGroup('UserLspConfig')
    :withEvent('BufWritePost')
    :withCallback(doformat)
    :create()
end

return LspAutocmds

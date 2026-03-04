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

local function disable_semantic_tokens(ev)
  local client = Lsp.get_client_by_id(ev.data.client_id)

  if client ~= nil then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local function disable_ruff_hover(ev)
  local client = Lsp.get_client_by_id(ev.data.client_id)

  if client ~= nil and client.name == 'ruff' then
    client.server_capabilities.hoverProvider = false
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
    :withDesc('Disable LSP semantic tokens so treesitter handles highlighting')
    :withGroup('UserLspConfig')
    :withEvent('LspAttach')
    :withCallback(disable_semantic_tokens)
    :create()

  Autocmd.new()
    :withDesc('Disable ruff hover so pyright handles hover')
    :withGroup('UserLspConfig')
    :withEvent('LspAttach')
    :withCallback(disable_ruff_hover)
    :create()
end

return LspAutocmds

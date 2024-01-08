local LspKM = require 'lsp.keymap'


local LSP_SERVERS = { 'bashls', 'lua_ls', 'pyright' }

--- Configures neovim LSP and related functionality.
---
---@class Lsp
local Lsp = {}

---@return string[]: an array-like table w/ configured lsp servers
function Lsp.servers()
  return LSP_SERVERS
end


local function require_config_for_server(lsp_server)
  return require('lsp.servers.' .. lsp_server)
end


local function get_config_for_server(lsp_server, capabilities, navic_attach)
  local server_conf = require_config_for_server(lsp_server)

  -- TODO: figure out how to better organize code so plugin specific lsp conf doesn't
  --       need to be centralized here
  local cmp_conf = { capabilities = capabilities }

  return Table.combine_many({ cmp_conf, server_conf })
end


--- Entry point to LSP configuration.
function Lsp.config()
  local lspconfig    = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, lsp_server in ipairs(LSP_SERVERS) do
    local conf = get_config_for_server(lsp_server, capabilities, navic_attach)
    lspconfig[lsp_server].setup(conf)
  end

  LspKM.add_keymap()
end

return Lsp


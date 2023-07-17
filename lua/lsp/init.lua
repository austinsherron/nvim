local lsp = require 'lsp.keymap'
local tbl = require 'lib.lua.core.table'


local LSP_SERVERS = { 'bashls', 'lua_ls', 'pyright' }

local Lsp = {}

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
  local navic_conf = { on_attach = navic_attach }

  return tbl.combine_many({ cmp_conf, navic_conf, server_conf })
end


function Lsp.config()
  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local navic_attach = require('nvim-navic').attach

  for _, lsp_server in ipairs(LSP_SERVERS) do
    local conf = get_config_for_server(lsp_server, capabilities, navic_attach)
    lspconfig[lsp_server].setup(conf)
  end

  lsp.keymap()
end

return Lsp


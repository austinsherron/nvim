require 'lib.lua.table'

local lsp = require 'nvim.lua.config.lsp.keymappings'


local LSP_SERVERS = { 'lua_ls', 'pyright' }

local Lsp = {}

function Lsp.servers()
  return LSP_SERVERS
end


local function get_config_for_server(lsp_server)
    return require('nvim.lua.config.lsp.' .. lsp_server)
end


function Lsp.config()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, lsp_server in ipairs(LSP_SERVERS) do
    local server_conf = get_config_for_server(lsp_server)
    -- TODO: figure out how to better organize code so plugin specific lsp conf doesn't
    --       need to be centralized here
    local final_conf = table.combine({ capabilities = capabilities }, server_conf)

    lspconfig[lsp_server].setup(final_conf)
  end

  lsp.keymappings()
end

return Lsp


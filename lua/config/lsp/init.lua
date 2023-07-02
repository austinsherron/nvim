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

  for _, lsp_server in ipairs(LSP_SERVERS) do
    local conf = get_config_for_server(lsp_server)
    lspconfig[lsp_server].setup(conf)
  end

  lsp.keymappings()
end

return Lsp


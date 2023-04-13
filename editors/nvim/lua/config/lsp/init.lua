local LSP_SERVERS = { 'lua_ls', 'pyright' }

function lsp_servers()
  return LSP_SERVERS
end


local function get_config_for_server(lsp_server)
    return require('nvim.lua.config.lsp.' .. lsp_server)
end


function lspconfig_config()
  local lspconfig = require('lspconfig')

  for _, lsp_server in ipairs(LSP_SERVERS) do
    local config = get_config_for_server(lsp_server)
    lspconfig[lsp_server].setup(config)
  end
end


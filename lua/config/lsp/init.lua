require 'nvim.lua.config.lsp.keymappings'


local LSP_SERVERS = { 'lua_ls', 'pyright' }

local function servers()
  return LSP_SERVERS
end


local function get_config_for_server(lsp_server)
    return require('nvim.lua.config.lsp.' .. lsp_server)
end


local function config()
  local lspconfig = require('lspconfig')

  for _, lsp_server in ipairs(LSP_SERVERS) do
    local conf = get_config_for_server(lsp_server)
    lspconfig[lsp_server].setup(conf)
  end

  lsp_keymappings()
end


return {
  config = config,
  servers = servers,
}


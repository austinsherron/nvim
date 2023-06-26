require 'nvim.lua.config.lsp'


function mason_lspconfig_opts()
  return {
    ensure_installed = lsp_servers()
  }
end


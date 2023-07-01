local lsp = require 'nvim.lua.config.lsp'


local Msn = {}

function Msn.opts()
  return {
    ensure_installed = lsp.servers()
  }
end

return Msn


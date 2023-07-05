local lsp = require 'nvim.lua.lsp'


local Msn = {}

function Msn.opts()
  return {
    ensure_installed = lsp.servers()
  }
end

return Msn


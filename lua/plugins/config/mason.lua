local lsp = require 'nvim.lua.config.lsp'


local function opts()
  return {
    ensure_installed = lsp.servers()
  }
end


return {
  opts = opts,
}


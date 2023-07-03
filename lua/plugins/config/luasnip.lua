
local Ls = {}

function Ls.expand(args)
  require('luasnip').lsp_expand(args.body)
end


function Ls.config()
  local luasnip = require 'luasnip'

  luasnip.config.set_config {
    history = false,
    updateevents = 'TextChanged,TextChangedI',
  }

  require('luasnip/loaders/from_vscode').load()
end

return Ls


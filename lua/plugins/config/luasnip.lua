
--- Contains functions for configuring the luasnip plugin.
--
---@class LuaSnip
local LuaSnip = {}

--- Function passed to completion engine for snippet expansion.
--
---@param args { body: table }: contains a "body" argument needed by luasnip's
-- "lsp_expand" function
function LuaSnip.expand(args)
  require('luasnip').lsp_expand(args.body)
end


--- Configures the luasnip plugin.
function LuaSnip.config()
  local luasnip = require 'luasnip'

  luasnip.config.set_config({
    history = false,
    updateevents = 'TextChanged,TextChangedI',
  })

  require('luasnip/loaders/from_vscode').load()
end

return LuaSnip


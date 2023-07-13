local safe = require 'nvim.lua.utils.safe'


-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
safe.require('nvim.lua.core.bootstrap')

-- plugins ---------------------------------------------------------------------

-- note: settings/keymap may have dependency(ies) on plugins, so load these first
safe.call(function() safe.require('nvim.lua.utils.pluginmanager').init('plugins') end)

-- keymap ---------------------------------------------------------------------

safe.require('nvim.lua.keymap')

-- settings -------------------------------------------------------------------

safe.require('nvim.lua.core.settings')

-- appearance ------------------------------------------------------------------

safe.require('nvim.lua.core.appearance')


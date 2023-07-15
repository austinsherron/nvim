local safe = require 'nvim.lua.utils.errorhandling.safe'


-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
safe.require('nvim.lua.core.bootstrap')

-- plugins ---------------------------------------------------------------------

-- note: settings/keymap has dependencies on plugins, so load them first
safe.require('nvim.lua.utils.plugins.pluginmanager', function(m) m.init('plugins') end)

-- keymap ---------------------------------------------------------------------

safe.require('nvim.lua.keymap')

-- settings -------------------------------------------------------------------

safe.require('nvim.lua.core.settings')

-- appearance ------------------------------------------------------------------

safe.require('nvim.lua.core.appearance')


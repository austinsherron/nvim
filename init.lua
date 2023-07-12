local safe_require = require('nvim.lua.utils.import').safe_require


-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
safe_require('nvim.lua.core.bootstrap', 'notify')

-- plugins ---------------------------------------------------------------------

-- note: settings/keymap may have dependency(ies) on plugins, so load these first
safe_require('nvim.lua.utils.pluginmanager', 'notify').init('plugins')

-- keymap ---------------------------------------------------------------------

safe_require('nvim.lua.keymap', 'notify')

-- settings -------------------------------------------------------------------

safe_require('nvim.lua.core.settings', 'notify')

-- appearance ------------------------------------------------------------------

safe_require('nvim.lua.core.appearance', 'notify')


-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
require 'nvim.lua.core.bootstrap'

-- plugins ---------------------------------------------------------------------

-- note: settings/keymappings may have dependency(ies) on plugins, so load these first
require('nvim.lua.utils.pluginmanager').init('plugins')

-- keymap ---------------------------------------------------------------------

require 'nvim.lua.keymap'

-- settings -------------------------------------------------------------------

require 'nvim.lua.core.settings'
require 'nvim.lua.plugins.config.treesitter'

-- appearance ------------------------------------------------------------------

require 'nvim.lua.core.appearance'


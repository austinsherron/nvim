-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
require 'nvim.lua.config.bootstrap'

-- plugins ---------------------------------------------------------------------

-- note: settings/keymappings may have dependency(ies) on plugins, so load these first
require('nvim.lua.utils.pluginmanager').init('plugins')

-- keymappings -----------------------------------------------------------------

require 'nvim.lua.config.keymappings'
-- require 'nvim.lua.config.keymappings.general'
-- require 'nvim.lua.config.keymappings.nvimtree'

-- settings -------------------------------------------------------------------

require 'nvim.lua.config.settings'
require 'nvim.lua.plugins.config.treesitter'

-- appearance ------------------------------------------------------------------

require 'nvim.lua.config.appearance'


local km = require 'nvim.lua.utils.mapper'
local pm = require 'nvim.lua.utils.pluginmanager'


---- note: settings that should come before everything else

km.nnoremap('<Space>', '<Nop>')
 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---- load settings

require 'nvim.lua.config.keymappings.general'
require 'nvim.lua.config.settings'
-- require 'nvim.lua.config.treesitter'

---- load plugins

pm.init('plugins')


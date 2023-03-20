km = require 'nvim.lua.mapper'


---- note: settings that should come before everything else

km.nnoremap('<Space>', '<Nop>')
 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---- load settings

require 'nvim.lua.settings'
require 'nvim.lua.keymappings'


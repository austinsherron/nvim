local km = require 'nvim.lua.utils.mapper'


-- note: settings that should come before everything else

-- look & feel -----------------------------------------------------------------

-- disable netrw (recommended by nvim-tree.lua plugin installation guide)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- tell nvim to emit "24-bit, 'true' colors" to the terminal
vim.opt.termguicolors = true

-- interactions ----------------------------------------------------------------

-- remap space to no-op
km.nnoremap('<Space>', '<Nop>')
 
-- remap leaders to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

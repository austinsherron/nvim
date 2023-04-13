local km = require 'nvim.lua.utils.mapper'
require 'lib.lua.run'


-- note: settings that should come before everything else

-- internals -------------------------------------------------------------------

---- setup dirs for misc. state

local state_base = vim.fn.stdpath('state')

-- for storing for storing backups
local backup_path = state_base .. '/backup'
mkdir(state_base .. '/backup', true)
vim.o.backupdir = backup_path

-- for storing undo history
local undo_path = state_base .. '/undo'
mkdir(state_base .. '/undo', true)
vim.o.undodir = undo_path

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


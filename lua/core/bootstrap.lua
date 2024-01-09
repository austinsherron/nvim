local Shell     = require 'toolbox.system.shell'
local KeyMapper = require 'utils.core.mapper'
local Path      = require 'utils.api.vim.path'

local globals = vim.g
local o       = vim.o
local opt     = vim.opt


-- note: settings that should come before everything else

-- internals -------------------------------------------------------------------

---- setup dirs for misc state

local state_base = Path.state()

-- for storing for storing backups
local backup_path = state_base .. '/backup'
Shell.mkdir(backup_path, true)
o.backupdir = backup_path

-- for storing undo history
local undo_path = state_base .. '/undo'
Shell.mkdir(undo_path, true)
o.undodir = undo_path

-- look & feel -----------------------------------------------------------------

-- disable netrw (recommended by nvim-tree.lua plugin installation guide)
globals.loaded_netrw = 1
globals.loaded_netrwPlugin = 1

-- tell nvim to emit "24-bit, 'true' colors" to the terminal
opt.termguicolors = true

-- interactions ----------------------------------------------------------------

-- remap space to no-op
KeyMapper.quick_bind('<Space>', '<Nop>')

-- remap leaders to space
globals.mapleader = ' '
globals.maplocalleader = ' '

GetLogger('INIT'):info('Bootstrapping complete')


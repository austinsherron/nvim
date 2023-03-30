local km = require 'nvim.lua.utils.mapper'
local telescope = require('telescope.builtin')


-- interactions ----------------------------------------------------------------

km.nmap('<leader>ff', telescope.find_files)
km.nmap('<leader>fg', telescope.live_grep)
km.nmap('<leader>fb', telescope.buffers)
km.nmap('<leader>fh', telescope.help_tags)


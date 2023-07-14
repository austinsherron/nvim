local km = require 'nvim.lua.utils.core.mapper'
local telescope = require('telescope.builtin')


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'telescope: ' .. desc, nowait = true, silent = true }
end


-- interactions ----------------------------------------------------------------

km.nmap('<leader>ff', telescope.find_files,      options('find files'))
km.nmap('<leader>fg', telescope.live_grep,       options('grep in files'))
km.nmap('<leader>fb', telescope.buffers,         options('search buffers'))
km.nmap('<leader>fh', telescope.help_tags,       options('search help tags'))
km.nmap('<leader>fu', telescope.lsp_references,  options('search lsp references'))

-- extensions ------------------------------------------------------------------

km.nnoremap('<leader>fc', '<cmd>Telescope aerial<CR>',   options('search code symbols'))
km.nnoremap('<leader>fe', '<cmd>Telescope emoji<CR>',    options('search emojis'))
km.nnoremap('<leader>fp', '<cmd>Telescope projects<CR>', options('search projects'))
km.nnoremap('<leader>fr', '<cmd>Telescope frecency<CR>', options('find "frecent"'))
km.nnoremap('<leader>fn', '<cmd>Telescope undo<CR>',     options('search undo history'))


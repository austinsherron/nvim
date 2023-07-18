local tsc = require 'telescope.builtin'
local km  = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'telescope: ' .. desc, nowait = true, silent = true }
end


-- find ------------------------------------------------------------------------

km.nnoremap('<leader>fa', tsc.builtin,                   options('search telescope built-ins'))
km.nnoremap('<leader>fb', tsc.buffers,                   options('search buffers'))
km.nnoremap('<leader>fC', tsc.colorscheme,               options('search colorschemes'))
km.nnoremap('<leader>fc', '<cmd>Telescope aerial<CR>',   options('search code symbols'))
km.nnoremap('<leader>fe', '<cmd>Telescope emoji<CR>',    options('search emojis'))
km.nnoremap('<leader>ff', tsc.find_files,                options('search files'))
km.nnoremap('<leader>fg', tsc.git_bcommits,              options('search git files'))
km.nnoremap('<leader>fh', tsc.help_tags,                 options('search help tags'))
km.nnoremap('<leader>fn', '<cmd>Telescope undo<CR>',     options('search undo history'))
km.nnoremap('<leader>fp', '<cmd>Telescope projects<CR>', options('search projects'))
km.nnoremap('<leader>fr', '<cmd>Telescope frecency<CR>', options('search "frecent"'))
km.nnoremap('<leader>fs', tsc.live_grep,                 options('find string'))
km.nnoremap('<leader>ft', tsc.treesitter,                options('search treesitter symbols'))
km.nnoremap('<leader>fu', tsc.lsp_references,            options('find usages'))


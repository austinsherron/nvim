local Telescope = require 'telescope.builtin'
local KM        = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'telescope: ' .. desc, nowait = true, silent = true }
end

-- find ------------------------------------------------------------------------

KM.nnoremap('<leader>fa', Telescope.builtin,             options('search telescope built-ins'))
KM.nnoremap('<leader>fb', Telescope.buffers,             options('search buffers'))
KM.nnoremap('<leader>fC', Telescope.colorscheme,         options('search colorschemes'))
KM.nnoremap('<leader>fc', '<cmd>Telescope aerial<CR>',   options('search code symbols'))
KM.nnoremap('<leader>fe', '<cmd>Telescope emoji<CR>',    options('search emojis'))
KM.nnoremap('<leader>ff', Telescope.find_files,          options('search files'))
KM.nnoremap('<leader>fg', Telescope.git_bcommits,        options('search git files'))
KM.nnoremap('<leader>fh', Telescope.help_tags,           options('search help tags'))
KM.nnoremap('<leader>fn', '<cmd>Telescope undo<CR>',     options('search undo history'))
KM.nnoremap('<leader>fp', '<cmd>Telescope projects<CR>', options('search projects'))
KM.nnoremap('<leader>fr', '<cmd>Telescope frecency<CR>', options('search "frecent"'))
KM.nnoremap('<leader>fs', Telescope.live_grep,           options('find string'))
KM.nnoremap('<leader>ft', Telescope.treesitter,          options('search treesitter symbols'))
KM.nnoremap('<leader>fu', Telescope.lsp_references,      options('find usages'))


local Telescope = require 'plugins.extensions.telescope'
local Builtins  = require 'telescope.builtin'
local KM        = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'telescope: ' .. desc, nowait = true, silent = true }
end

-- find ------------------------------------------------------------------------

KM.nnoremap('<leader>fa',  Builtins.builtin,                    options('search telescope built-ins'))
KM.nnoremap('<leader>fb',  Builtins.buffers,                    options('search buffers'))
KM.nnoremap('<leader>fC',  Builtins.colorscheme,                options('search colorschemes'))
KM.nnoremap('<leader>fc',  '<cmd>Telescope aerial<CR>',         options('search code symbols'))
KM.nnoremap('<leader>fd',  Builtins.diagnostics,                options('search code symbols'))
KM.nnoremap('<leader>fe',  '<cmd>Telescope emoji<CR>',          options('search emojis'))
KM.nnoremap('<leader>ff',  Telescope.contextual_find_files,     options('search files'))
KM.nnoremap('<leader>fF',  Telescope.contextual_find_all_files, options('search all files (hidden, etc.)'))
KM.nnoremap('<leader>fgc', Builtins.git_bcommits,               options('search git commits'))
KM.nnoremap('<leader>fgs', Builtins.git_stash,                  options('search git stashes'))
KM.nnoremap('<leader>fh',  Builtins.help_tags,                  options('search help tags'))
-- KM.nnoremap('<leader>fn',  '<cmd>Telescope undo<CR>',       options('search undo history'))
KM.nnoremap('<leader>fm',  Builtins.man_pages,                  options('search man pages'))
KM.nnoremap('<leader>fn',  Telescope.search_packages,           options('search plugin files'))
KM.nnoremap('<leader>fp',  '<cmd>Telescope projects<CR>',       options('search projects'))
KM.nnoremap('<leader>fr',  '<cmd>Telescope frecency<CR>',       options('search "frecent"'))
KM.nnoremap('<leader>ft',  Builtins.treesitter,                 options('search treesitter symbols'))
KM.nnoremap('<leader>fu',  Builtins.lsp_references,             options('find usages'))
KM.nnoremap('<leader>fw',  Telescope.contextual_live_grep,      options('find words'))

-- remaps ----------------------------------------------------------------------

KM.nnoremap('<leader>su', Builtins.spell_suggest, options('spelling suggestions'))

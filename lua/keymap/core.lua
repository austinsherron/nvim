local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'core: ' .. desc, nowait = true }
end

-- interactions ---------------------------------------------------------------

---- core ops

-- save
KM.nnoremap('<leader>w', ':w<CR>',   options('save one'))
KM.nnoremap('<leader>W', ':wqa<CR>', options('save all + quit'))

-- close/quit
KM.nnoremap('<leader>q', ':q<CR>',   options('quit/close'))
KM.nnoremap('<leader>Q', ':qa<CR>',   options('quit/close all'))
KM.nnoremap('<leader>!', ':qa!<CR>', options('force quit'))

-- <esc>
KM.inoremap('jh',    '<Esc>',    options('exit/back'))
KM.inoremap('hj',    '<Esc>',    options('exit/back'))
KM.inoremap('jk',    '<Esc>',    options('exit/back'))
KM.inoremap('kj',    '<Esc>',    options('exit/back'))
KM.inoremap('<C-c>', '<Esc>',    options('exit/back'))

---- misc ops

-- toggle relative line numbers
KM.nmap('<C-N><C-N>', ':set invrelativenumber<CR>', options('toggle relative line #'))

-- close quickfix window
KM.nmap('<leader>cq', ':cclose<CR>', options('close quickfix window'))

-- motion ----------------------------------------------------------------------

---- wrapped lines

-- lets j and k move inside a visually wrapped line
KM.nnoremap('j', 'gj', options('cursor down'))
KM.nnoremap('k', 'gk', options('cursor up'))

-- display --------------------------------------------------------------------

-- turn off highlight (i.e.: for search, as wall as for searchbox.nvim plugin)
KM.nnoremap('<leader>hx', ':noh | :SearchBoxClear<CR>', options('cancel highlight'))

-- spellcheck ------------------------------------------------------------------

-- add word
KM.nnoremap('<leader>sa', 'zg', options('add word to dict.'))
-- suggest words
KM.nnoremap('<leader>su', 'z=', options('suggest word(s) for typo'))

-- buffers ---------------------------------------------------------------------

-- note: since all other buffer key bindings are dependent on the barbar plugin,
--       they're defined w/ the barbar plugin keymap

-- resize
KM.nnoremap('<leader>J', ':resize -10<CR>',          options('resize "up" 10'))
KM.nnoremap('<leader>K', ':resize +10<CR>',          options('resize "down" 10'))
KM.nnoremap('<leader>L', ':vertical resize -10<CR>', options('resize "right" 10'))
KM.nnoremap('<leader>H', ':vertical resize +10<CR>', options('resize "left" 10'))


local km = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'core: ' .. desc, nowait = true }
end


-- interactions ---------------------------------------------------------------

---- core ops

-- save
km.nnoremap('<leader>w', ':w<CR>',   options('save one'))
km.nnoremap('<leader>W', ':wqa<CR>', options('save all + quit'))

-- close/quit
km.nnoremap('<leader>q', ':q<CR>',   options('quit/close'))
km.nnoremap('<leader>Q', ':qa<CR>',   options('quit/close all'))
km.nnoremap('<leader>!', ':qa!<CR>', options('force quit'))

-- <esc>
km.inoremap('jh',    '<Esc>',    options('exit/back'))
km.inoremap('hj',    '<Esc>',    options('exit/back'))
km.inoremap('jk',    '<Esc>',    options('exit/back'))
km.inoremap('kj',    '<Esc>',    options('exit/back'))
km.inoremap('<C-c>', '<Esc>',    options('exit/back'))

---- misc ops

-- toggle relative line numbers
km.nmap('<C-N><C-N>', ':set invrelativenumber<CR>', options('toggle relative line #'))

-- motion ----------------------------------------------------------------------

---- wrapped lines

-- lets j and k move inside a visually wrapped line
km.nnoremap('j', 'gj', options('cursor down'))
km.nnoremap('k', 'gk', options('cursor up'))

-- display --------------------------------------------------------------------

-- turn off highlight (i.e.: for search, as wall as for searchbox.nvim plugin)
km.nnoremap('<leader>hx', ':noh | :SearchBoxClear<CR>', options('cancel highlight'))

-- spellcheck ------------------------------------------------------------------

-- add word
km.nnoremap('<leader>sa', 'zg', options('add word to dict.'))
-- suggest words
km.nnoremap('<leader>su', 'z=', options('suggest word(s) for typo'))

-- buffers ---------------------------------------------------------------------

-- note: since all other buffer key bindings are dependent on the barbar plugin,
--       they're defined w/ the barbar plugin keymap

-- resize
km.nnoremap('<leader>J', ':resize +10<CR>',          options('resize "up" 10'))
km.nnoremap('<leader>K', ':resize -10<CR>',          options('resize "down" 10'))
km.nnoremap('<leader>L', ':vertical resize +10<CR>', options('resize "right" 10'))
km.nnoremap('<leader>H', ':vertical resize -10<CR>', options('resize "left" 10'))


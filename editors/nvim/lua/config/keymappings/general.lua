local km = require 'nvim.lua.utils.mapper'

-- interactions ---------------------------------------------------------------

---- core ops

-- save
km.nnoremap('<leader>w', ':w<CR>')      -- one
km.nnoremap('<leader>W', ':wqa<CR>')    -- all + quit

-- close/quit
km.nnoremap('<leader>q', ':q<CR>')      -- quit/close one (if saved)
km.nnoremap('<leader>Q', ':qa!<CR>')    -- force quit all

-- <esc>
km.inoremap('jh', '<Esc>')
km.inoremap('hj', '<Esc>')
km.inoremap('jk', '<Esc>')
km.inoremap('kj', '<Esc>')
km.inoremap('<C-c>', '<Esc>')

-- redo
km.nnoremap('<leader>r', '<C-r>')

---- misc ops

-- toggle relative line numbers
km.nmap('<C-L><C-L>', ':set invrelativenumber<CR>')

-- navigation -----------------------------------------------------------------

---- splits

km.nnoremap('<C-h>', '<C-w>h')
km.nnoremap('<C-j>', '<C-w>j')
km.nnoremap('<C-k>', '<C-w>k')
km.nnoremap('<C-l>', '<C-w>l')

---- wrapped lines

-- lets j and k move inside a visually wrapped line
km.nnoremap('j', 'gj')
km.nnoremap('k', 'gk')

-- display --------------------------------------------------------------------

-- turn off highlight (i.e.: for search)
km.nnoremap('<leader>hx', ':noh<CR>')

-- spellcheck ------------------------------------------------------------------

-- add word
km.nnoremap('<leader>aw', 'zg')
-- suggest words
km.nnoremap('<leader>sw', 'z=')


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
km.nnoremap('<leader>r', '<C-r>', { nowait = true })

---- misc ops

-- toggle relative line numbers
km.nmap('<C-N><C-N>', ':set invrelativenumber<CR>')

-- navigation -----------------------------------------------------------------

---- splits

km.nnoremap('<silent><C-h>', ':NvimTmuxNavigateLeft<CR>')
km.nnoremap('<silent><C-j>', ':NvimTmuxNavigateDown<CR>')
km.nnoremap('<silent><C-k>', ':NvimTmuxNavigateUp<CR>')
km.nnoremap('<silent><C-l>', ':NvimTmuxNavigateRight<CR>')

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


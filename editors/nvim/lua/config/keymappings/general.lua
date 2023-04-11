local km = require 'nvim.lua.utils.mapper'

-- display --------------------------------------------------------------------

km.nnoremap('<leader>hx', ':noh<cr>')

-- navigation -----------------------------------------------------------------

-- easy split navigation
km.nnoremap('<C-h>', '<C-w>h')
km.nnoremap('<C-j>', '<C-w>j')
km.nnoremap('<C-k>', '<C-w>k')
km.nnoremap('<C-l>', '<C-w>l')

-- interactions ---------------------------------------------------------------

km.inoremap('jh', '<Esc>')
km.inoremap('hj', '<Esc>')
km.inoremap('jk', '<Esc>')
km.inoremap('kj', '<Esc>')
km.inoremap('<C-c>', '<Esc>')

km.nnoremap('<leader>r', '<c-r>')

-- toggle relative line numbers
km.nmap('<C-L><C-L>', ':set invrelativenumber<CR>')

-- let's j and k move inside a visually wrapped line
km.nnoremap('j', 'gj')
km.nnoremap('k', 'gk')
km.xnoremap('j', 'gj')
km.xnoremap('k', 'gk')

-- easy buffer interactions
km.nnoremap('<leader>n', ':bn<cr>')
km.nnoremap('<leader>p', ':bp<cr>')
km.nnoremap('<leader>x', ':bd<cr>:bn<cr>')
-- km.nnoremap('<leader><M-Tab>', ':bn<cr>')
-- km.nnoremap('<leader><M-S-Tab>', ':bp<cr>')
-- km.nnoremap('<silent><leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>')

-- resize buffers
km.nnoremap('<leader>J', ':resize +10<cr>')
km.nnoremap('<leader>K', ':resize -10<cr>')
km.nnoremap('<leader>L', ':vertical resize +10<cr>')
km.nnoremap('<leader>H', ':vertical resize -10<cr>')

-- map misc ':' commands to <leader>c
km.nnoremap('<leader>w', ':w<cr>')
km.nnoremap('<leader>W', ':wq<cr>')
km.nnoremap('<leader>aW', ':wqa<cr>')
km.nnoremap('<leader>q', ':q<cr>')
km.nnoremap('<leader>Q', ':q!<cr>')


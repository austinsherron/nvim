km = require 'nvim.lua.utils.mapper'


-- navigation -----------------------------------------------------------------

-- easy buffer navigation
km.map('<leader>bn', ':bn<cr>')
km.map('<leader>bp', ':bp<cr>')

-- easy split navigation
km.nnoremap('<C-h>', '<C-w>h')
km.nnoremap('<C-j>', '<C-w>j')
km.nnoremap('<C-k>', '<C-w>k')
km.nnoremap('<C-l>', '<C-w>l')

-- commands -------------------------------------------------------------------

-- interactions ---------------------------------------------------------------

km.inoremap('jk', '<Esc>')
km.inoremap('kj', '<Esc>')

km.nnoremap('<leader>r', '<c-r>')

-- toggle relative line numbers
km.nmap('<C-L><C-L>', ':set invrelativenumber<CR>')

-- let's j and k move inside a visually wrapped line
km.nnoremap('j', 'gj')
km.nnoremap('k', 'gk')
km.xnoremap('j', 'gj')
km.xnoremap('k', 'gk')


local km = require 'nvim.lua.utils.mapper'

-- display --------------------------------------------------------------------

km.nnoremap('<leader>hx', ':noh<cr>')

-- spellcheck ------------------------------------------------------------------

km.nnoremap('<leader>aw', 'zg')
km.nnoremap('<leader>sw', 'z=')

-- navigation -----------------------------------------------------------------

-- easy split navigation
km.nnoremap('<C-h>', '<C-w>h')
km.nnoremap('<C-j>', '<C-w>j')
km.nnoremap('<C-k>', '<C-w>k')
km.nnoremap('<C-l>', '<C-w>l')

-- let's j and k move inside a visually wrapped line
km.nnoremap('j', 'gj')
km.nnoremap('k', 'gk')
km.xnoremap('j', 'gj')
km.xnoremap('k', 'gk')

-- interactions ---------------------------------------------------------------

-- various `<esc>` remappings
km.inoremap('jh', '<Esc>')
km.inoremap('hj', '<Esc>')
km.inoremap('jk', '<Esc>')
km.inoremap('kj', '<Esc>')
km.inoremap('<C-c>', '<Esc>')

-- redo
km.nnoremap('<leader>r', '<c-r>')

-- toggle relative line numbers
km.nmap('<C-L><C-L>', ':set invrelativenumber<CR>')

-- save/quit
km.nnoremap('<leader>w', ':w<cr>')
km.nnoremap('<leader>W', ':wqa<cr>')
km.nnoremap('<leader>q', ':q<cr>')
km.nnoremap('<leader>Q', ':q!<cr>')

-- buffers ---------------------------------------------------------------------

-- switch buffers
km.nnoremap('<leader>n', ':bn<cr>')
km.nnoremap('<leader>p', ':bp<cr>')
km.nnoremap('<silent><leader>x', ':bd<cr>:bn<cr>')
km.nnoremap('<leader>bp', ':BufferPick<cr>')

-- resize buffers
km.nnoremap('<leader>J', ':resize +10<cr>')
km.nnoremap('<leader>K', ':resize -10<cr>')
km.nnoremap('<leader>L', ':vertical resize +10<cr>')
km.nnoremap('<leader>H', ':vertical resize -10<cr>')

-- reorder buffers
km.nnoremap('<leader>bd', ':BufferOrderByDirectory<cr>')
km.nnoremap('<leader>b#', ':BufferOrderByBufferNumber<cr>')
km.nnoremap('<leader>bl', ':BufferOrderByLanguage<cr>')

-- close buffers

km.nnoremap('<leader>bx', ':BufferCloseAllButCurrent<cr>')
km.nnoremap('<leader>bX', ':BufferWipeout<cr>')


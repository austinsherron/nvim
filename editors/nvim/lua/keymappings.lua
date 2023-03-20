km = require 'nvim.lua.mapper'


-- navigation -----------------------------------------------------------------

km.map('<leader>bn', ':bn<cr>')
km.map('<leader>bp', ':bp<cr>')

---- tmux/nvim navigator plugin settings: to easily navigate b/w tmux panes while
---- in nvim

vim.g.tmux_navigator_no_mappings = 1

km.noremap('<silent> <c-h>', ':<C-U>TmuxNavigateLeft<cr>')
km.noremap('<silent> <c-j>', ':<C-U>TmuxNavigateDown<cr>')
km.noremap('<silent> <c-k>', ':<C-U>TmuxNavigateUp<cr>')
km.noremap('<silent> <c-l>', ':<C-U>TmuxNavigateRight<cr>')
km.noremap('<silent> <c-;>', ':<C-U>TmuxNavigatePrevious<cr>')

-- commands -------------------------------------------------------------------

-- interactions ---------------------------------------------------------------

km.inoremap('jk', '<Esc>')
km.inoremap('kj', '<Esc>')
km.nnoremap('<leader>r', '<c-r>')

-- let's j and k move inside a visually wrapped line
km.nnoremap('j', 'gj')
km.nnoremap('k', 'gk')
km.xnoremap('j', 'gj')
km.xnoremap('k', 'gk')


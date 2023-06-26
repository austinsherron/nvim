local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>dv', ':DiffviewOpen<CR>')
km.nnoremap('<leader>dx', ':DiffviewClose<CR>')
km.nnoremap('<leader>dh', ':DiffviewFileHistory<CR>')
km.nnoremap('<leader>df', ':DiffviewFileHistory %<CR>')


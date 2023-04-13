local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap("'", '<Plug>(leap-forward-till)')
km.nnoremap('"', '<Plug>(leap-backward-till)')


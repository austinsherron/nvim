local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>u', ':UndotreeToggle | UndotreeFocus<CR>')
km.nnoremap('<leader>2', ':UndotreeShow | UndotreeFocus<CR>')


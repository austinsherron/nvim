local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>1', ':NvimTreeFocus<CR>')
km.nnoremap('<leader>t', ':NvimTreeToggle<CR>')
km.nnoremap('<leader>F', ':NvimTreeFindFile<CR>')
km.nnoremap('<leader>F!', ':NvimTreeFindFile!<CR>')


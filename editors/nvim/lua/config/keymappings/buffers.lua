local km = require 'nvim.lua.utils.mapper'


-- navigation ------------------------------------------------------------------

---- sequential

-- next
km.nnoremap('<C-]>',     ':BufferNext<CR>')
km.nnoremap('<leader>n', ':BufferNext<CR>')

-- prev
km.nnoremap('<C-[>',     ':BufferPrevious<CR>')
km.nnoremap('<leader>p', ':BufferPrevious<CR>')

---- extended

-- chose arbitrary
km.nnoremap('<leader>bp', ':BufferPick<CR>')

-- core ops --------------------------------------------------------------------

---- close/delete

-- current
km.nnoremap('<M-w>',     ':BufferDelete<CR>')
km.nnoremap('<leader>x', ':BufferDelete<CR>')

-- all but current
km.nnoremap('<leader>bX', ':BufferCloseAllButCurrent<CR>')

-- restore
km.nnoremap('<M-T>',      ':BufferRestore<CR>')
km.nnoremap('<leader>br', ':BufferRestore<CR>')

-- misc ops --------------------------------------------------------------------

-- pin
km.nnoremap('<leader>bn', ':BufferPin<CR>')

-- resize
km.nnoremap('<leader>J', ':resize +10<CR>')
km.nnoremap('<leader>K', ':resize -10<CR>')
km.nnoremap('<leader>L', ':vertical resize +10<CR>')
km.nnoremap('<leader>H', ':vertical resize -10<CR>')

-- reorder
km.nnoremap('<leader>bd', ':BufferOrderByDirectory<CR>')
km.nnoremap('<leader>b#', ':BufferOrderByBufferNumber<CR>')
km.nnoremap('<leader>bl', ':BufferOrderByLanguage<CR>')


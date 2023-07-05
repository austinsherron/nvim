local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'buffers: ' .. desc, nowait = true }
end


-- navigation ------------------------------------------------------------------

---- sequential

-- next
km.nnoremap('<M-l>',     ':BufferNext<CR>', options('next'))
km.nnoremap('<leader>n', ':BufferNext<CR>', options('next'))

-- prev
km.nnoremap('<M-h>',     ':BufferPrevious<CR>', options('previous'))
km.nnoremap('<leader>p', ':BufferPrevious<CR>', options('previous'))

---- extended

km.nnoremap('<leader>b1', ':BufferFirst<CR>', options('choose first'))
km.nnoremap('<leader>b9', ':BufferLast<CR>',  options('choose last'))
km.nnoremap('<leader>ba', ':BufferPick<CR>',  options('choose any'))

-- core ops --------------------------------------------------------------------

---- close/delete

-- current
km.nnoremap('<M-w>',     ':BufferClose<CR>', options('close'))
km.nnoremap('<leader>x', ':BufferClose<CR>', options('close'))

-- all but current
km.nnoremap('<leader>X', ':BufferCloseAllButCurrent<CR>', options('close all but current'))

-- restore
km.nnoremap('<M-T>',      ':BufferRestore<CR>', options('restore'))
km.nnoremap('<leader>br', ':BufferRestore<CR>', options('restore'))

-- misc ops --------------------------------------------------------------------

-- pin
km.nnoremap('<leader>bp', ':BufferPin<CR>', options('pin'))

-- reorder
km.nnoremap('<leader>bd', ':BufferOrderByDirectory<CR>',    options('order by dir'))
km.nnoremap('<leader>b#', ':BufferOrderByBufferNumber<CR>', options('order by #'))
km.nnoremap('<leader>bl', ':BufferOrderByLanguage<CR>',     options('order by lang.'))


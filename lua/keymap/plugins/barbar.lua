local km = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'buffers: ' .. desc, nowait = true }
end


-- navigation ------------------------------------------------------------------

---- sequential

-- next
km.nnoremap('<leader>n', ':BufferNext<CR>', options('next'))
km.nnoremap('<M-]>',     ':BufferNext<CR>', options('next'))

-- prev
km.nnoremap('<leader>p', ':BufferPrevious<CR>', options('previous'))
km.nnoremap('<M-[>',     ':BufferPrevious<CR>', options('previous'))

---- jump to...

-- w/ leader
km.nnoremap('<leader>b1', ':BufferGoto 1<CR>', options('go to 1'))
km.nnoremap('<leader>b2', ':BufferGoto 2<CR>', options('go to 2'))
km.nnoremap('<leader>b3', ':BufferGoto 3<CR>', options('go to 3'))
km.nnoremap('<leader>b4', ':BufferGoto 4<CR>', options('go to 4'))
km.nnoremap('<leader>b5', ':BufferGoto 5<CR>', options('go to 5'))
km.nnoremap('<leader>b6', ':BufferGoto 6<CR>', options('go to 6'))
km.nnoremap('<leader>b7', ':BufferGoto 7<CR>', options('go to 7'))
km.nnoremap('<leader>b8', ':BufferGoto 8<CR>', options('go to 8'))
km.nnoremap('<leader>b9', ':BufferGoto 9<CR>', options('go to 9'))
km.nnoremap('<leader>b0', ':BufferLast<CR>',   options('go to last'))
km.nnoremap('<leader>bg', ':BufferPick<CR>',   options('go to...'))

-- with meta (i.e.: alt/option)
km.nnoremap('<M-1>', ':BufferGoto 1<CR>', options('go to 1'))
km.nnoremap('<M-2>', ':BufferGoto 2<CR>', options('go to 2'))
km.nnoremap('<M-3>', ':BufferGoto 3<CR>', options('go to 3'))
km.nnoremap('<M-4>', ':BufferGoto 4<CR>', options('go to 4'))
km.nnoremap('<M-5>', ':BufferGoto 5<CR>', options('go to 5'))
km.nnoremap('<M-6>', ':BufferGoto 6<CR>', options('go to 6'))
km.nnoremap('<M-7>', ':BufferGoto 7<CR>', options('go to 7'))
km.nnoremap('<M-8>', ':BufferGoto 8<CR>', options('go to 8'))
km.nnoremap('<M-9>', ':BufferGoto 9<CR>', options('go to 9'))
km.nnoremap('<M-0>', ':BufferLast<CR>',   options('go to last'))
km.nnoremap('<M-p>', ':BufferPick<CR>',   options('go to...'))

local i = 0

if i == 0 then
end

-- core ops --------------------------------------------------------------------

---- close/delete

-- current
km.nnoremap('<leader>x', ':BufferClose<CR>', options('close'))
km.nnoremap('<M-w>',     ':BufferClose<CR>', options('close'))

-- all but current
km.nnoremap('<leader>X', ':BufferCloseAllButCurrent<CR>', options('close all but current'))
km.nnoremap('<S-M-X>',   ':BufferCloseAllButCurrent<CR>', options('close all but current'))

-- restore
km.nnoremap('<leader>br',   ':BufferRestore<CR>', options('restore'))
km.nnoremap('<S-M-T>',      ':BufferRestore<CR>', options('restore'))

-- misc ops --------------------------------------------------------------------

-- pin
km.nnoremap('<leader>bp', ':BufferPin<CR>', options('pin'))

-- reorder
km.nnoremap('<leader>bd', ':BufferOrderByDirectory<CR>',    options('order by dir'))
km.nnoremap('<leader>b#', ':BufferOrderByBufferNumber<CR>', options('order by #'))
km.nnoremap('<leader>bl', ':BufferOrderByLanguage<CR>',     options('order by lang.'))


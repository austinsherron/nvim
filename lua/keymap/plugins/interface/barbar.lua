local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'buffers: ' .. desc, nowait = true }
end

-- navigation ------------------------------------------------------------------

---- sequential

-- next
KM.nnoremap('<leader>n', ':BufferNext<CR>', options('next'))
KM.nnoremap('<M-]>',     ':BufferNext<CR>', options('next'))

-- prev
KM.nnoremap('<leader>p', ':BufferPrevious<CR>', options('previous'))
KM.nnoremap('<M-[>',     ':BufferPrevious<CR>', options('previous'))

---- jump to...

-- w/ leader
KM.nnoremap('<leader>b1', ':BufferGoto 1<CR>', options('go to 1'))
KM.nnoremap('<leader>b2', ':BufferGoto 2<CR>', options('go to 2'))
KM.nnoremap('<leader>b3', ':BufferGoto 3<CR>', options('go to 3'))
KM.nnoremap('<leader>b4', ':BufferGoto 4<CR>', options('go to 4'))
KM.nnoremap('<leader>b5', ':BufferGoto 5<CR>', options('go to 5'))
KM.nnoremap('<leader>b6', ':BufferGoto 6<CR>', options('go to 6'))
KM.nnoremap('<leader>b7', ':BufferGoto 7<CR>', options('go to 7'))
KM.nnoremap('<leader>b8', ':BufferGoto 8<CR>', options('go to 8'))
KM.nnoremap('<leader>b9', ':BufferGoto 9<CR>', options('go to 9'))
KM.nnoremap('<leader>b0', ':BufferLast<CR>',   options('go to last'))
KM.nnoremap('<leader>bg', ':BufferPick<CR>',   options('go to...'))

-- with meta (i.e.: alt/option)
KM.nnoremap('<M-1>', ':BufferGoto 1<CR>', options('go to 1'))
KM.nnoremap('<M-2>', ':BufferGoto 2<CR>', options('go to 2'))
KM.nnoremap('<M-3>', ':BufferGoto 3<CR>', options('go to 3'))
KM.nnoremap('<M-4>', ':BufferGoto 4<CR>', options('go to 4'))
KM.nnoremap('<M-5>', ':BufferGoto 5<CR>', options('go to 5'))
KM.nnoremap('<M-6>', ':BufferGoto 6<CR>', options('go to 6'))
KM.nnoremap('<M-7>', ':BufferGoto 7<CR>', options('go to 7'))
KM.nnoremap('<M-8>', ':BufferGoto 8<CR>', options('go to 8'))
KM.nnoremap('<M-9>', ':BufferGoto 9<CR>', options('go to 9'))
KM.nnoremap('<M-0>', ':BufferLast<CR>',   options('go to last'))
KM.nnoremap('<M-p>', ':BufferPick<CR>',   options('go to...'))

-- core ops --------------------------------------------------------------------

---- close/delete

-- current
KM.nnoremap('<leader>x', ':BufferClose<CR>', options('close'))
KM.nnoremap('<M-w>',     ':BufferClose<CR>', options('close'))

-- all but current
KM.nnoremap('<leader>X', ':BufferCloseAllButCurrent<CR>', options('close all but current'))
KM.nnoremap('<S-M-X>',   ':BufferCloseAllButCurrent<CR>', options('close all but current'))

-- restore
KM.nnoremap('<leader>br',   ':BufferRestore<CR>', options('restore'))
KM.nnoremap('<S-M-T>',      ':BufferRestore<CR>', options('restore'))

-- misc ops --------------------------------------------------------------------

-- pin
KM.nnoremap('<leader>bp', ':BufferPin<CR>', options('pin'))

-- reorder
KM.nnoremap('<leader>bd', ':BufferOrderByDirectory<CR>',    options('order by dir'))
KM.nnoremap('<leader>b#', ':BufferOrderByBufferNumber<CR>', options('order by #'))
KM.nnoremap('<leader>bl', ':BufferOrderByLanguage<CR>',     options('order by lang.'))


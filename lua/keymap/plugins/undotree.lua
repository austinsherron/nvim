local km = require 'nvim.lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'undotree: ' .. desc, nowait = true }
end


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>u', ':UndotreeToggle | UndotreeFocus<CR>', options('toggle'))
km.nnoremap('<leader>2', ':UndotreeShow | UndotreeFocus<CR>',   options('open'))


local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'undotree: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>u', ':UndotreeToggle | UndotreeFocus<CR>', options('toggle'))
KM.nnoremap('<leader>2', ':UndotreeShow | UndotreeFocus<CR>',   options('open'))


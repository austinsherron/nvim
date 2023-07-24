local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'aerial: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>a', ':AerialToggle<CR>',    options('toggle sidebar'))
KM.nnoremap('<leader>A', ':AerialNavToggle<CR>', options('toggle popup'))


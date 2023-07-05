local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'aerial: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>a',  ':AerialToggle<CR>',    options('open sidebar'))
km.nnoremap('<leader>A',  ':AerialNavToggle<CR>', options('open popup'))


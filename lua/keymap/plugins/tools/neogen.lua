local KM = require 'lua.utils.core.mapper'


-- neogen ----------------------------------------------------------------======

-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'neogen: ' .. desc, nowait = true }
end

KM.nnoremap('<leader>Df', ':Neogen func<CR>',  options('function docstring'))
KM.nnoremap('<leader>Dc', ':Neogen class<CR>', options('class docstring'))


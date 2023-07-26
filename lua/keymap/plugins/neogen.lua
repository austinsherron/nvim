local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'neogen: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>gf', ':Neogen func<CR>',  options('function docstring'))
KM.nnoremap('<leader>gc', ':Neogen class<CR>', options('class docstring'))


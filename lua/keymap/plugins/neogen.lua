local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'neogen: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>D',  ':Neogen func<CR>',  options('function docstring'))
KM.nnoremap('<leader>Df', ':Neogen func<CR>',  options('function docstring'))
KM.nnoremap('<leader>Dc', ':Neogen class<CR>', options('class docstring'))


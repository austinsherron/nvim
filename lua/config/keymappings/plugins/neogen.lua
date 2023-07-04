local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'neogen: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>Nf', ':Neogen func<CR>',  options('function docstring'))
km.nnoremap('<leader>Nc', ':Neogen class<CR>', options('class docstring'))


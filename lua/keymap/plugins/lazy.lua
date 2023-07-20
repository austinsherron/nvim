local KM = require 'utils.core.mapper'


-- interactions ----------------------------------------------------------------

local options = {
    desc = 'lazy: open plugin mgr.',
    nowait = true,
    silent = true,
}

KM.nnoremap('<leader>Z', ':Lazy<CR>', options)


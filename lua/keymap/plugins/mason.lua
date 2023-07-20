local KM = require 'utils.core.mapper'


-- interactions ----------------------------------------------------------------

local options = {
    desc = 'mason: open lsp mgr.',
    nowait = true,
    silent = true,
}

KM.nnoremap('<leader>M', ':Mason<CR>', options)


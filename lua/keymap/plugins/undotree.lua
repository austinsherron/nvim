local KM = require 'utils.core.mapper'


local options = {
    desc = 'undo: toggle',
    nowait = true,
    silent = true,
}

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>2', ':UndotreeToggle | UndotreeFocus<CR>', options)


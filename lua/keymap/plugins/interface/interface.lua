local KM = require 'utils.core.mapper'


-- alpha -----------------------------------------------------------------------

KM.nnoremap('<leader>0', ':Alpha<CR>', { desc = 'alpha: open startpage' })

-- notify ----------------------------------------------------------------------

KM.nnoremap('<leader>3', ':Notifications<CR>', { desc = 'notify: notification history' })

-- undotree --------------------------------------------------------------------

local options = { desc = 'undo: toggle', nowait = true, silent = true }

KM.nnoremap('<leader>2', ':UndotreeToggle | UndotreeFocus<CR>', options)



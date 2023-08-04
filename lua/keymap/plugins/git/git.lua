local KM = require 'lua.utils.core.mapper'


-- diffview --------------------------------------------------------------------

-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'diffview: ' .. desc, nowait = true }
end

KM.nnoremap('<leader>dv', ':DiffviewOpen<CR>',          options('open diff/merge view'))
KM.nnoremap('<leader>dx', ':DiffviewClose<CR>',         options('close diff/merge view'))
KM.nnoremap('<leader>dh', ':DiffviewFileHistory<CR>',   options('show all history'))
KM.nnoremap('<leader>df', ':DiffviewFileHistory %<CR>', options('show file history'))

-- neogit ----------------------------------------------------------------------

KM.nnoremap('<leader>G', ':Neogit<CR>', { desc = 'neogit: open' })


local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'diff-view: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>dv', ':DiffviewOpen<CR>',          options('open diff/merge view'))
KM.nnoremap('<leader>dx', ':DiffviewClose<CR>',         options('close diff/merge view'))
KM.nnoremap('<leader>dh', ':DiffviewFileHistory<CR>',   options('show all history'))
KM.nnoremap('<leader>df', ':DiffviewFileHistory %<CR>', options('show file history'))


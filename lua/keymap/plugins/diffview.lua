local km = require 'nvim.lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'diff-view: ' .. desc, nowait = true }
end


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>dv', ':DiffviewOpen<CR>',          options('open diff/merge view'))
km.nnoremap('<leader>dx', ':DiffviewClose<CR>',         options('close diff/merge view'))
km.nnoremap('<leader>dh', ':DiffviewFileHistory<CR>',   options('show all history'))
km.nnoremap('<leader>df', ':DiffviewFileHistory %<CR>', options('show file history'))


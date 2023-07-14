local km = require 'nvim.lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'nvim-tmux: ' .. desc, nowait = true }
end


-- motion ----------------------------------------------------------------------

---- splits/panes

km.nnoremap('<silent><C-h>', ':NvimTmuxNavigateLeft<CR>',  options('mv left'))
km.nnoremap('<silent><C-j>', ':NvimTmuxNavigateDown<CR>',  options('mv down'))
km.nnoremap('<silent><C-k>', ':NvimTmuxNavigateUp<CR>',    options('mv up'))
km.nnoremap('<silent><C-l>', ':NvimTmuxNavigateRight<CR>', options('mv right'))


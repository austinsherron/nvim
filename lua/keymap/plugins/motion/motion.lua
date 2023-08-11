local KM = require 'utils.core.mapper'


-- nvim-tmux nav ---------------------------------------------------------------

-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'nvim-tmux: ' .. desc, nowait = true }
end

KM.nnoremap('<silent><C-h>', ':NvimTmuxNavigateLeft<CR>',  options('mv left'))
KM.nnoremap('<silent><C-j>', ':NvimTmuxNavigateDown<CR>',  options('mv down'))
KM.nnoremap('<silent><C-k>', ':NvimTmuxNavigateUp<CR>',    options('mv up'))
KM.nnoremap('<silent><C-l>', ':NvimTmuxNavigateRight<CR>', options('mv right'))


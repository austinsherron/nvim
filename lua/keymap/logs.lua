local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'logs: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>l', ':UserLogs vsplit<CR>', options('open in vsplit'))
KM.nnoremap('<leader>L', ':UserLogs<CR>',        options('open'))


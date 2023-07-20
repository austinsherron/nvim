local KM = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'session mgr.' .. desc }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>ss', ':SessionManager save_current_session<CR>',     options('save current'))
KM.nnoremap('<leader>sl', ':SessionManager load_last_session<CR>',        options('load last'))
KM.nnoremap('<leader>sd', ':SessionManager load_current_dir_session<CR>', options('load current dir'))


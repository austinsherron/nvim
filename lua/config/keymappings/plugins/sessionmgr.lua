local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'session mgr.' .. desc }
end


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>ss', ':SessionManager save_current_session<CR>',     options('save current'))
km.nnoremap('<leader>sl', ':SessionManager load_last_session<CR>',        options('load last'))
km.nnoremap('<leader>sd', ':SessionManager load_current_dir_session<CR>', options('load current dir'))


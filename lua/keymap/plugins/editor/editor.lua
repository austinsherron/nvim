local SessionMgr = require 'plugins.extensions.sessionmgr'
local KM         = require 'utils.core.mapper'


-- session mgr. ----------------------------------------------------------------

-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'session mgr.' .. desc }
end

KM.nnoremap('<leader>ss', ':SessionManager save_current_session<CR>',     options('save'))
KM.nnoremap('<leader>sr', ':SessionManager load_last_session<CR>',        options('restore last'))
KM.nnoremap('<leader>sd', ':SessionManager load_current_dir_session<CR>', options('restore for cwd'))
KM.nnoremap('<leader>sl', SessionMgr.list,                                options('list'))


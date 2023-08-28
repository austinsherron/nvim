local SessionMgr = require 'plugins.extensions.sessionmgr'
local KeyMapper  = require 'utils.core.mapper'


local KM = KeyMapper.new()

-- session mgr. ----------------------------------------------------------------

KM:with({ desc_prefix = 'session mgr.: ' })
  :bind({
    { '<leader>ss', ':SessionManager save_current_session<CR>',     { desc = 'save'            }},
    { '<leader>sr', ':SessionManager load_last_session<CR>',        { desc = 'restore last'    }},
    { '<leader>sd', ':SessionManager load_current_dir_session<CR>', { desc = 'restore for cwd' }},
    { '<leader>sl',  SessionMgr.list,                               { desc = 'list'            }},
}):done()


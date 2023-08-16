local Path = require 'utils.api.vim.path'


local SESSIONS_DIR = Path.data() .. '/sessions'

--- Contains functions for configuring the session manager plugin.
---
---@class SessionMgr
local SessionMgr = {}

--- Configures the session manager plugin.
function SessionMgr.config()
  local AutoloadMode = require('session_manager.config').AutoloadMode

  require('session_manager').setup({
    -- same as default but want to make explicit since this has other dependencies
    sessions_dir = SESSIONS_DIR,
    -- disabling so I can take matters into my own hands;
    -- see lua/core/auto/before/workspace.lua
    -- TODO: the above wasn't working due to barbar integration issue; will figure this
    --       out soon, but need to revert in the meantime
    autload_mode = AutoloadMode.CurrentDir,
  })
end


---@return string: the path to the directory where sessions are stored
function SessionMgr.sessions_dir()
  return SESSIONS_DIR
end

return SessionMgr


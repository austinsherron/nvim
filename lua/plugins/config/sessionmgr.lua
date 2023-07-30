
--- Contains functions for configuring the session manager plugin.
--
---@class SessionMgr
local SessionMgr = {}

--- Configures the session manager plugin.
function SessionMgr.config()
  local AutoloadMode = require('session_manager.config').AutoloadMode

  require('session_manager').setup({
    autload_mode = AutoloadMode.CurrentDir,
  })
end

return SessionMgr


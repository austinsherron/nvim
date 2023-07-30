local Shell            = require 'lib.lua.system.shell'
local SessionCmd       = require 'utils.session.cmd'
local SessionConfig    = require 'utils.session.config'
local SessionConfigMgr = require 'utils.session.configmgr'


local Setup = {}

--- Entry point for initializing and configuring session manager.
---@param config SessionConfig?: a session configuration object
function Setup.setup(config)
  local session_config = SessionConfig.new(config):fill()
  Shell.mkdir(session_config.dir, true)

  SessionConfigMgr.save(session_config)

  SessionCmd.usercmds()
  SessionCmd.autocmds()
end

return Setup


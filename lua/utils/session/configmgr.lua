local File   = require 'lib.lua.system.fs'
local Path   = require 'utils.api.path'
local Config = require 'utils.session.config'


local CONFIG_PATH = Path.data() .. '/session-mgr/.session-config.json'

--- Manages session configuration.
--
---@class SessionConfigMgr
local SessionConfigMgr = {}


--- Loads saved content and uses it to create a new session manager instance. If saved
--  content is not present, the default config is used.
--
---@return SessionConfig: a new session instance constructed w/ saved content,
-- if present
function SessionConfigMgr.load()
  local content, err = File.read(CONFIG_PATH)

  if content == nil then
    error('Session: unable to read config; err=' .. (err or '?'))
  elseif err ~= nil then
    Warn('Session: non-fatal error reading config; err=' .. err)
  end

  return Config.from_json(content):fill()
end


--- Saves the provided session config.
---
---@param config SessionConfig: the session config to save
function SessionConfigMgr.save(config)
  local content = config:to_json()
  local err = File.write(CONFIG_PATH, content)

  if err ~= nil then
    error('Session: unable to write config; err=' .. err)
  end
end

return SessionConfigMgr


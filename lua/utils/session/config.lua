local String = require 'lib.lua.core.string'
local Json   = require 'utils.api.json'
local Path   = require 'utils.api.path'
local TMerge = require 'utils.api.tablemerge'
local Namer  = require 'utils.session.name'

local validate = vim.validate


-- SessionNameConfig -----------------------------------------------------------

---@class SessionNameConfig
---@field strategy NamingStrategyKey?: how to name sessions; optional, defaults to
-- NamingStrategyKey.DIR, at time of writing
local SessionNameConfig = {}
SessionNameConfig.__index = SessionNameConfig

--- Constructor
function SessionNameConfig.new(strategy)
  return setmetatable({ strategy = strategy }, SessionNameConfig)
end

-- SessionConfig ---------------------------------------------------------------

---@class SessionConfig
---@field dir string?: the directory in which to save sessions; optional, defaults to
-- "data" dir, at time of writing
---@field name SessionNameConfig?: configures session naming
local SessionConfig = {}
SessionConfig.__index = SessionConfig

--- Constructor
--
---@param config SessionConfig?: a session config table
---@return SessionConfig: a new SessionConfig instance
function SessionConfig.new(config)
  return setmetatable(config or {}, SessionConfig)
end


local CONFIG_SPEC = function(c)
  local root = {
    dir = { c.dir, 'string', true },
    name = { c.name, 'table', true },
  }

  if c.name == nil then
    return root
  end

  root.name = {
    name_strategy = {
      c.name.strategy,
      Namer.is_strategy,
      c.name.strategy .. ' is not a valid naming strategy'
    },
  }

  return root
end


local function validate_config(c)
  validate(CONFIG_SPEC(c))
end


--- Validates this config instance.
--
---@return SessionConfig: self
function SessionConfig:validate()
  validate_config(self)
  return self
end

---@type SessionConfig
local DEFAULT = {
  dir  = Path.data() .. '/session-mgr/sessions',
  name = {
    strategy = Namer.default_strategy(),
  },
}

---@return SessionConfig: the default session config
function SessionConfig.default()
  return DEFAULT
end


--- Constructs an instance from the provided serialized SessionConfig.
--
---@param json_string string?: a serialized representation of a SessionConfig instance
---@return SessionConfig: a SessionConfig instance constructed from the provided json
-- string
function SessionConfig.from_json(json_string)
  if String.is_nil_or_empty(json_string) then
    return SessionConfig.default()
  end

---@diagnostic disable-next-line: return-type-mismatch, param-type-mismatch
  return SessionConfig.new(Json.decode(json_string))
end


--- Merges the provided session config, "o" (other), w/ this config. Values in this
--  instance will be preserved in the event of key collisions.
--
---@param o SessionConfig: the config to merge into this config
---@return SessionConfig: a config object in which o has been merged into this config
function SessionConfig:merge(o)
  return SessionConfig.new(
    TMerge.mergeleft(o, self)
  )
end


--- "Fills" any values missing from this config object by merging this w/ the default
--  config.
--
---@return SessionConfig: a config object in which the default config has been merged into
-- this config
function SessionConfig:fill()
  return self:merge(self.default())
end


--- Serializes the config instance to a json string.
--
---@return string: a json string representation of the config object
function SessionConfig:to_json()
---@diagnostic disable-next-line: return-type-mismatch
  return Json.encode(self)
end

return SessionConfig


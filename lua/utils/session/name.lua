---@diagnostic disable: unused-local

local String  = require 'lib.lua.core.string'
local Table   = require 'lib.lua.core.table'
local Set     = require 'lib.lua.extensions.set'
local Path    = require 'lib.lua.system.path'
local Git     = require 'utils.api.git'
local System  = require 'utils.api.system'


local NAME_SEP = '_'
local SLASH_SEP = '-'
local STRATEGY_SEP = '='


-- NamingStrategyKey -----------------------------------------------------------

--- Indicates how sessions should be named.
--
---@enum NamingStrategyKey
local NamingStrategyKey = {
  BRANCH      = 'branch',        -- names based on current git branch
  -- TODO: think through impl, not totally sure how this would work
  CUSTOM      = 'custom',        -- names based on a user defined function
  DIR         = 'directory',     -- names based on the current directory
  REPO        = 'repository',    -- names based on the current git repo
}

---@type Set
NamingStrategyKey.ALL = Set.new(Table.values(NamingStrategyKey))
NamingStrategyKey.REV = Table.reverse_items(NamingStrategyKey)

local function key_name(key)
  return NamingStrategyKey.REV[key]
end

-- NamingStrategy --------------------------------------------------------------

--- Maps NamingStrategyKey entries to naming logic.
--
---@enum NamingStrategy
local NamingStrategy = {
  [NamingStrategyKey.BRANCH]      = function(c) return Git.branch_name() end,
  [NamingStrategyKey.CUSTOM]      = function(c) return '' end,
  [NamingStrategyKey.DIR]         = function(c) return System.cwd():gsub('/', SLASH_SEP) end,
  [NamingStrategyKey.REPO]        = function(c) return Git.repo_name() end,
}

-- SessionNamer ----------------------------------------------------------------

--- Implements session naming logic.
--
---@class SessionNamer
local SessionNamer = {}

---@return NamingStrategyKey: the default session naming strategy
function SessionNamer.default_strategy()
  return NamingStrategyKey.DIR
end


--- Returns true if the provided string is a valid session naming strategy.
--
---@param maybe_strategy string?: the string to check
---@return boolean: true if the provided string is a valid session naming strategy, false otherwise
function SessionNamer.is_strategy(maybe_strategy)
  return NamingStrategyKey.ALL:contains(maybe_strategy)
end


--- Creates a session name w/ the provided session naming strategy key.
--
---@param config SessionNameConfig: configures session naming behavior
---@return string: a session name constructed based on the provided config
function SessionNamer.mkname(config)
  local strategy = NamingStrategy[config.strategy]
  return key_name(config.strategy) .. STRATEGY_SEP .. strategy(config) .. '.vim'
end


function SessionNamer.format(name)
  local filename = Path.trim_extension(name)
  local parts = String.split(filename, STRATEGY_SEP)

  if parts == nil then
    Error('Error encountered parsing session name=' .. filename)
    return name
  end

  local strategy_key, file = parts[1], parts[2]
  local path = file:gsub(SLASH_SEP, '/')

  return String.capitalize(strategy_key) .. ': ' .. path
end

return SessionNamer


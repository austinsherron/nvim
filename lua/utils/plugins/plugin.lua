require 'lazy.types'

local Stream = require 'toolbox.extensions.stream'


--- Internal helper that exists to clear a plugin's __index function and avoid infinite recursion.
---
---@class _Plugin
local _Plugin = {}
_Plugin.__index = _Plugin

function _Plugin.new(this)
  setmetatable(this, _Plugin)
  return this
end

--- A helper that wraps a lazy.nvim plugin definition so that all references to function
--- properties are wrapped in error handling.
---
---@class Plugin
local Plugin = {}
Plugin.__index = Plugin

--- Constructor
---
---@param plugin LazyPlugin: a lazy.nvim plugin definition
---@return Plugin: a new Plugin instance
function Plugin.new(plugin)
  setmetatable(plugin, Plugin)
---@diagnostic disable-next-line: return-type-mismatch
  return plugin
end


--- Constructs multiple plugins from an array of plugin definitions.
---
---@param plugins LazyPlugin: an array-like table of lazy.nvim plugin definitions
---@return Plugin[]: an array-like table of Plugin instances
function Plugin.all(plugins)
  return Stream(plugins)
    :map(Plugin.new)
    :get()
end


--- Ensure any access of an instance's function properties is wrapped in error handling/
---
---@param key string: the name of the property being accessed
---@return any?: the property being accessed, or nil if that's a key's value or the key
--- isn't present in the instance
function Plugin:__index(key)
  local internal = _Plugin.new(self)
  local value = internal[key]

  if value == nil or type(value) ~= 'function' then
    return value
  end

  return function(...)
    local args = Table.pack(...)

    return OnErr.notify(
      function() return value(Table.unpack(args)) end,
      (internal.name or 'unknownPlugin') .. '.' .. key
    )
  end
end

--- Exported Plugin constructors.
---
---@class Plgn
local Plgn = {}

---@see Plugin.new
function Plgn.plugin(def)
  return Plugin.new(def)
end


---@see Plugin.all
function Plgn.plugins(def)
  return Plugin.all(def)
end

return Plgn


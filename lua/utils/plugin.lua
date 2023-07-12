require 'lazy.types'

local onerr = require 'nvim.lua.utils.onerr'


--- Internal helper that exists to clear a plugin's __index function and avoid infinite recursion.
--
---@class _Plugin
local _Plugin = {}
_Plugin.__index = _Plugin

function _Plugin.new(this)
  setmetatable(this, _Plugin)
  return this
end

--- A helper that wraps a lazy.nvim plugin definition so that all references to function
--  properties are wrapped in error handling.
--
---@class Plugin
local Plugin = {}
Plugin.__index = Plugin

--- Constructor
--
---@param this LazyPluginBase: a lazy.nvim plugin definition
---@return Plugin
function Plugin.new(this)
  setmetatable(this, Plugin)
---@diagnostic disable-next-line: return-type-mismatch
  return this
end


--- Ensure any access of an instance's function properties is wrapped in error handling/
--
---@param key string: the name of the property being accessed
---@return any?: the property being accessed, or nil if that's a key's value or the key
-- isn't present in the instance
function Plugin:__index(key)
  local internal = _Plugin.new(self)
  local value = internal[key]

  if value == nil or type(value) ~= 'function' then
    return value
  end

  return function(...)
    local args = table.pack(...)

    return onerr.notify(
      function() return value(table.unpack(args)) end,
      (internal.name or 'unknownPlugin') .. '.' .. key
    )
  end
end

return function(def)
  return Plugin.new(def)
end



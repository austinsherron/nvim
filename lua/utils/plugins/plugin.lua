local Type   = require 'toolbox.meta.type'


--- An adapter that takes a lazy.nvim plugin definition and wraps all function references
--- in error handling.
---
---@class Plugin
---@field private plugin table
local Plugin = {}
Plugin.__index = Plugin

local function plugin_name(plugin)
  return plugin[1] or '?'
end


local function wrap_fn(name, fn_name, fn)
  return function(...)
    local fqdn = fmt('%s.%s', name, fn_name)

    Trace('Lazy plugin setup: calling "%s"', { fqdn })

    return Safe.call(fn, 'log', fqdn, ...)
  end
end


--- Constructor
---
---@param plugin table: a lazy.nvim plugin definition
---@return Plugin: a new Plugin instance
function Plugin.new(plugin)
  local name = plugin_name(plugin)

  Debug('Initializing plugin="%s"', { name })

  Stream.new(Table.keys(plugin))
    :filter(function(k) return Type.isfunc(plugin[k]) end)
    :foreach(function(k) plugin[k] = wrap_fn(name, k, plugin[k]) end)

  return setmetatable(plugin, Plugin)
end


--- Constructs multiple plugins from an array of plugin definitions.
---
---@param category string: the category of plugin being loaded; used for logging
---@param plugins table[]: an array-like table of lazy.nvim plugin definitions
---@return Plugin[]: an array-like table of Plugin instances
function Plugin.all(category, plugins)
  InfoQuietly('Initializing %s plugins', { category })

  return Stream.new(plugins)
    :map(Plugin.new)
    :get()
end

return {
  plugin  = Plugin.new,
  plugins = Plugin.all,
}


local Env = require 'toolbox.system.env'
local PluginMgr = require 'utils.plugins.pluginmanager'
local Shell = require 'toolbox.system.shell'

local function packages_exist()
  return Table.not_nil_or_empty(Shell.ls(Env.nvundle()))
end

-- if we're doing a fresh install, download all plugins up front
if not packages_exist() then
  PluginMgr.init 'plugins.all'
end

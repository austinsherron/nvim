local Env = require 'toolbox.system.env'
local Path = require 'toolbox.system.path'
local Shell = require 'toolbox.system.shell'

--- Contains functions for configuring the project plugin.
---
---@class Project
local Project = {}

local function known_exclusions()
  return {
    '^' .. Path.config(), -- exclude everything in config dir
    '^' .. Env.dotfiles(), -- exclude dotfile submodules
    '^' .. Env.external_pkgs(), -- exclude external repos
    '^' .. Env.nvim_root(), -- exclude nvim plugins
  }
end

local function work_exclusions()
  if String.nil_or_empty(Env.work_root()) then
    return {}
  end

  -- ensure exclusion work project subdirs
  return map(Shell.ls(Env.work_root()), function(project)
    return '^' .. project
  end)
end

local function exclusions()
  return Array.concatenated(known_exclusions(), work_exclusions())
end

---@return table: a table that contains configuration values for the project plugin
function Project.opts()
  return {
    detection_methods = { 'pattern' },
    exclude_dirs = exclusions(),
    scope_chdir = 'tab',
  }
end

return Project

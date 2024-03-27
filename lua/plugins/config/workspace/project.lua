local Env = require 'toolbox.system.env'
local Path = require 'toolbox.system.path'
local Shell = require 'toolbox.system.shell'

local LOGGER = GetLogger 'PLUGINS'

--- Contains functions for configuring the project plugin.
---
---@class Project
local Project = {}

local function ancestor_path(path)
  return '^' .. path
end

local function known_exclusions()
  return {
    Path.config(), -- exclude everything in config dir
    Env.dotfiles(), -- exclude dotfile submodules
    Env.external_pkgs(), -- exclude external repos
    Env.nvim_root(), -- exclude nvim plugins
  }
end

local function work_exclusions()
  if String.nil_or_empty(Env.work_root()) then
    return {}
  end

  return Array.concatenated(
    -- ensure exclusion of work project subdirs
    Shell.ls(Env.work_root()),
    -- ensure exclusion paths in "work path"
    Shell.split_path(Env.work_path())
  )
end

local function exclusions()
  return map(Array.concatenated(known_exclusions(), work_exclusions()), function(path)
    path = ancestor_path(path)
    LOGGER:debug('project.nvim: adding %s to exclusion list', { path })
    return path
  end)
end

---@return table: a table that contains configuration values for the project plugin
function Project.opts()
  return {
    detection_methods = { 'pattern' },
    exclude_dirs = exclusions(),
    patterns = { '.git' },
    scope_chdir = 'tab',
  }
end

return Project

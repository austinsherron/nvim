local Env = require 'toolbox.system.env'

--- Contains functions for configuring the project plugin.
---
---@class Project
local Project = {}

local function known_exclusions()
  return {
    Env.editors_root() .. '/nvim', -- exclude nvim submodule
    Env.external_pkgs() .. '/*', -- exclude external repos
    Env.nvim_root_pub(), -- exclude "deployed" nvim
    Env.nvundle() .. '/*', -- exclude plugins
    Env.nvim_root_pub() .. '/packages/*', -- exclude "deployed" plugins
    Env.tmux_bundle(), -- exclude tmux plugins
  }
end

local function exclusions()
  local exclude_dirs = known_exclusions()

  if String.not_nil_or_empty(Env.work_root()) then
    Array.append(exclude_dirs, Env.work_root() .. '/*/*')
  end

  return exclude_dirs
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

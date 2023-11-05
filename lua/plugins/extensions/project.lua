local System = require 'utils.api.vim.system'

local project_nvim = require 'project_nvim'


--- Contains utilities for interacting w/ projects.
---
--- TODO: this is incomplete and unused at the moment.
---
---@class Projects
local Projects = {}

--- Gets an array of recent project paths.
---
---@return string[]: an array of recent project paths; may be empty, but shouldn't be nil
function Projects.get_recent_projects()
  return project_nvim.get_recent_projects()
end


--- Gets the "name" (name of the root directory) of the current project, if any.
---
---@return string|nil: the "name" (name of the root directory) of the current project, if
--- any
function Projects.get_current_project()
  local cwd = System.cwd()
  local recent_projects = Projects.get_recent_projects()

  for _, project in ipairs(recent_projects) do
    print(fmt('%s == %s?', cwd, project))
  end
end

return Projects


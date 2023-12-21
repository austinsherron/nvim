local Path    = require 'toolbox.system.path'
local Project = require 'utils.api.project'
local Session = require 'utils.api.session'


---@alias LualineComponent { [1]: fun(): string, cond: fun(): boolean, draw_empty: boolean }

--- Implements a custom lualine component that reports on the active project, session, and
--- cwd.
---
---@class ProjectContext
local ProjectContext = {}

---@return boolean: true if the component is available and should be displayed, which for
--- this component is when the cwd is a project dir or a subdir of one; false otherwise
function ProjectContext.is_available()
  return Project.cwd_in_project()
end


---@return string: the current project, cwd, and session context
function ProjectContext.get()
  local cwd_is_project = Project.cwd_is_project()
  local project = Project.current(Path.basename)
  local bang_or_not = ternary(cwd_is_project, '', '!')

  local session_exists = Session.exists()
  local icon = ternary(session_exists, '󰠘', '󱙄')

  return fmt('%s%s %s', project, bang_or_not, icon)
end


---@return boolean: true if the component should be drawn when empty, false otherwise
function ProjectContext.draw_empty()
  return true
end

--- Contains functions that return custom statusline components in the format expected by
--- lualine.
---
---@class Lualine
local Lualine = {}

---@return LualineComponent: the project context component in the format expected by
--- lualine
function Lualine.project_context()
  return {
    ProjectContext.get,
    cond       = ProjectContext.is_available,
    draw_empty = true,
  }
end

return Lualine


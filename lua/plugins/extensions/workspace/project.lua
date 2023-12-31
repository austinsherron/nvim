local ProjectApi = require 'utils.api.project'
local Session    = require 'utils.api.session'

local ActionUtils = require('plugins.extensions.search').Telescope.ActionUtils

local telescope = require 'telescope'
local config    = require 'telescope.config'

config = config.values


--- Contains functions that implement extended (custom) project and session management
--- functionality.
---
---@class Project
local Project = {}

local function default_action(selection)
  local project_dir = Table.safeget(selection, 'value')
  if project_dir == nil then return end

  local session = Session.get(project_dir)

  if session == nil then
    Warn('No project session found; switching to project=%s', { project_dir })
    return ProjectApi.switch(project_dir)
  end

  InfoQuietly('Switching to project session=%s', { session.name })
  Session.switch(session)
end


local function make_attachment_action()
  return ActionUtils.replace_default_action(Safe.ify(default_action))
end


local function projects_picker()
  telescope.extensions.projects.projects({
    attach_mappings = make_attachment_action(),
    layout_strategy = 'vertical',
    layout_config   = { height = 0.4, width = 0.5 },
  })
end


--- Opens the project.nvim telescope picker w/ a custom default action. The new default
--- action saves the session for the current cwd, closes all buffers, changes the cwd to
--- the dir of the selected project, and loads the project's session.
function Project.picker()
  projects_picker()
end

return Project


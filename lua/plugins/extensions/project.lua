local Session = require 'utils.api.session'
local Buffer  = require 'utils.api.vim.buffer'
local System  = require 'utils.api.vim.system'

local DirScope = System.DirScope

local telescope    = require 'telescope'
local actions      = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local config       = require 'telescope.config'

config = config.values


--- Contains functions that implement extended (custom) project and session management
--- functionality.
---
---@class Project
local Project = {}

local function get_project_dir_and_session()
    local selection = action_state.get_selected_entry()
    local project_dir = selection.value

    return project_dir, Session.get(project_dir)
end


local function cd_and_load_session(project_dir, session)
  if project_dir == nil then
    return
  end

  Buffer.closeall()
  ---@diagnostic disable-next-line: undefined-field
  System.cd(project_dir, DirScope.TAB)

  if session ~= nil then
    Session.load(session.file_path)
  end
end


local function make_project_selection_action(prompt_bufnr)
  return function()
    actions.close(prompt_bufnr)
    Session.save()

    local project_dir, session = get_project_dir_and_session()
    cd_and_load_session(project_dir, session)
  end
end


local function projects_picker()
  telescope.extensions.projects.projects({
    attach_mappings = function(prompt_bufnr)
      local action = make_project_selection_action(prompt_bufnr)
      actions.select_default:replace(action)
      return true
    end
  })
end


--- Opens the project.nvim telescope picker w/ a custom default action. The new default
--- action saves the session for the current cwd, closes all buffers, changes the cwd to
--- the dir of the selected project, and loads the project's session, if it exists.
function Project.picker()
  projects_picker()
end

return Project


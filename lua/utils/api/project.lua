local Buffer = require 'utils.api.vim.buffer'
local Git = require 'utils.api.git'
local Lambda = require 'toolbox.functional.lambda'
local System = require 'utils.api.vim.system'

local Collectors = Stream.Collectors

local project_nvim = require 'project_nvim'

--- Api wrapper around project plugin.
---
---@class Project
local Project = {}

--- Gets recent projects, if any.
---
---@generic T
---@param process (fun(project_path: string): T)|nil: optional; a transform function that
--- works on individual projects
---@return string[]: an array of recent projects, if any, optionally transformed by
--- process
function Project.recents(process)
  process = process or Lambda.IDENTITY

  local projects = project_nvim.get_recent_projects() or {}
  return Stream.new(projects):map(process):collect()
end

--- Checks whether a project exists at dir_path.
---
---@param dir_path string: the dir_path to check
---@return boolean: true if a project exists at dir_path, false otherwise
function Project.exists(dir_path)
  local project = Stream.new(Project.recents())
    :filter(Lambda.EQUALS_THIS(dir_path))
    :collect(Collectors.to_only(false))

  return project ~= nil
end

--- Gets the current project, based on the cwd's git root.
---
--- Note: a project may not exist for the current cwd, or the cwd may not exist in a git
--- repo.

---@generic T
---@param process (fun(project_path: string): T)|nil: optional; a transform function that
--- works on individual projects
---@return T|nil: the current project, based on the cwd's git root, if both exist;
--- optionally transformed by process
function Project.current(process)
  if not Git.in_repo() then
    return ''
  end

  process = process or Lambda.IDENTITY

  local repo_root = Git.repo_root()
  return Stream.new(Project.recents())
    :filter(Lambda.EQUALS_THIS(repo_root))
    :map(process)
    :collect(Collectors.to_only(false))
end

---@return boolean: true if the cwd is or is a subdir of a project dir, false otherwise
function Project.cwd_in_project()
  return Project.current() ~= nil
end

---@return boolean: true if the cwd is a project dir, false otherwise
function Project.cwd_is_project()
  local current = Project.current()
  return current ~= nil and System.cwd() == current
end

--- Closes all buffers and changes the cwd to project_dir.
---
---@param project_dir string: the root dir of the project to cd into
function Project.switch(project_dir)
  Buffer.closeall()
  System.cd(project_dir)
end

return Project

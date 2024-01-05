local File   = require 'toolbox.system.file'
local Path   = require 'toolbox.system.path'
local System = require 'utils.api.vim.system'

local enum = require('toolbox.extensions.enum').enum
local map  = require('toolbox.utils.map').map

--- Contains functions for interacting w/ git.
---
--- Note: most functions assume the cwd is in a git repo.
---
---@class Git
local Git = {}

--- Models possible git file statuses.
---
---@enum GitStatus
local GitStatus = enum({
  MODIFIED = 'M',
  NEW      = 'A',
  DELETED  = 'D',
  UNKNOWN  = '??'
})

---@note: so GitStatus is publicly exposed
Git.Status = GitStatus

--- Models a git file.
---
---@class GitFile
---@field path string: the file's absolute path
---@field name GitStatus: the file's last known git status
local GitFile = {}
GitFile.__index = GitFile

---@note: so GitFile is publicly exposed
Git.File = GitFile

--- Constructor
---
---@param path string: see field docstring
---@param status GitStatus: see field docstring
---@return GitFile: a new instance
function GitFile.new(path, status)
  return setmetatable({ path = path, status = status }, GitFile)
end


--- Parses a file status string as it's returned from "git status --porcelain".
---
---@param status_str string: a file status string
---@return GitFile: a new instance
function GitFile.parse(status_str)
  local parts = String.split(status_str)

  if #parts < 2 then
    Err.raise('GitFile.parse: status string=%s in unexpected format', status_str)
  end

  if not GitStatus:is_value(parts[1]) then
    Err.raise('GitFile.parse: unknown status=%s', parts[1])
  end

  local path = Git.repo_root() .. '/' .. parts[2]
  local status = GitStatus[parts[1]]

  return GitFile.new(path, status)
end


---@return boolean: true if the cwd is in a git repo, false otherwise
function Git.in_repo()
  local fn = function()
    return System.run('git rev-parse --is-inside-work-tree')
  end

  return (OnErr.as_bool(fn))
end


---@return string: the path to the root of the repo we're in currently
function Git.repo_root()
  return String.trim(System.run('git rev-parse --show-toplevel'), '\n')
end


--- Gets abspath relative to the current repo root.
---
---@param abspath string: the absolute path to a file in the current repo
---@return string: the repo file path relative to the current repo root path
function Git.repo_path(abspath)
  return Path.relative(Git.repo_root(), abspath)
end


---@return string|nil: the name of the repo we're in currently
function Git.repo_name()
  return Path.basename(Git.repo_root())
end


---@return string: the name of the active branch of the repo we're in currently
function Git.branch_name()
  return System.run('git rev-parse --abbrev-ref HEAD')
end


---@return GitFile[]: the statuses of files in the current repo
function Git.status()
  local raw = String.split_lines(System.run('git status --porcelain')) or {}
  return map(raw, GitFile.parse)
end


--- Gets the files in the current repo that have been changed.
---
---@param staged boolean|nil: optional, defaults to false; if true, only return
--- staged files
---@return string[]: the files in the current repo that have been changed,
--- optionally filtered to staged files
function Git.diff_files(staged)
  if staged ~= true then
    -- use git status here to ensure inclusion of untracked files
    return map(Git.status(), function(s) return s.path end)
  end

  local raw = System.run('git diff --name-only --staged')
  local relative = String.split_lines(raw) or {}
  local root = Git.repo_root()

  return map(relative, function(r) return root .. '/' .. r end)
end


--- Checks if path is staged. If path is a dir, checks that all changed children of path
--- are staged.
---
---@param path string: the absolute path to check
---@return boolean: true if path is staged or all changed children of path are staged,
--- false otherwise
function Git.is_staged(path)
  local is_dir = File.is_dir(path)
  local staged = Set.new(Git.diff_files(true))

  if is_dir == nil then
    Err.raise('Git.is_staged: %s does not exist', path)
  end

  if not is_dir then
    return staged:contains(path)
  end

  local children = Set.new(Path.get_children(path, Git.diff_files()))
  return children:subset_of(staged)
end


--- Stages the file/files at the provided path.
---
---@param path string?: optional, defaults to "."; the path to stage
function Git.stage(path)
  System.run('git add ' .. (path or '.'))
end


--- Unstages the file/files at the provided path.
---
---@param path string?: optional, defaults to "."; the path to un-stage
function Git.unstage(path)
  System.run('git reset HEAD ' .. (path or '.'))
end


--- "Resets" (reverts) unstaged changes at the provided path.
---
---@param path string?: the path to reset; if nil or empty, no change will be affected
function Git.reset(path)
  if String.not_nil_or_empty(path) then
    System.run('git checkout -- ' .. path)
  end
end


--- Stashes changes in the working directory.
---
---@param msg string?: a description of the changes being stashed
function Git.stash(msg)
  local msg_arg = ternary(
    String.not_nil_or_empty(msg),
    function() return ' -m ' .. msg end,
    ''
  )
  System.run('git stash ' .. msg_arg)
end


--- Clones the provided github repo to dir w/ the given options.
---
---@param repo string: the repo to clone in the form "owner/repo-name", w/o .git suffix
---@param dir string|nil: the path to which to clone the repo; if nil, uses the cwd
---@param options table|nil: options to pass to the clone command; flags should not be
--- prefixed w/ "--"
function Git.clone(repo, dir, options)
  options = Table.map_items(
    options or {},
    { keys = function(k, v) return fmt('--%s=%s', k, v) end }
  )

  local url = 'https://github.com/' .. repo .. '.git'
  local cmd = Table.concat({
    { 'git', 'clone', },
    options,
    { url },
    ternary(dir == nil, {}, { dir }),
  })

  System.run(cmd)
end


--- Contains utilities for setting git configuration values.
---
---@class Config
local Config = {}

---@note: to export the Config class
Git.Config = Config

--- Sets a git configuration value.
---
---@param key string: the key of the config
---@param value string: the value of the config
---@param section string|nil: optional, defaults to "core"; the section or "block" (i.e.:
--- in a .gitconfig) in which the config lives
---@param scope string|nil: optional, defaults to "global"; the scope at which to set the
--- config
function Config.set(key, value, section, scope)
  section = section or 'core'
  scope = scope or 'global'

  Debug(
    'Git.Config.set: setting %s.%s to %s (scope=%s)',
    { section, key, value, scope }
  )

  System.run(fmt('git config --%s %s.%s %s', scope, section, key, value))
end


--- Sets the git (commit) editor globally.
---
---@param editor string: the editor command to set
---@param ... string|nil: arguments to the editor command
function Config.set_editor(editor, ...)
  if not System.executable(editor) then
    Error(fmt('Git.Config.set_editor: no such executable exists: %s', editor))
    -- Err.raise('Git.Config.set_editor: no such executable exists: %s', editor)
  end

  local cmd_parts = Table.concat({{ editor }, Table.pack(...) })
  local cmd = String.join(cmd_parts, ' ')

  Config.set('editor', cmd)
end

return Git


local Path   = require 'toolbox.system.path'
local System = require 'utils.api.vim.system'


--- Contains functions for interacting w/ git.
---
--- Note: most functions assume the cwd is in a git repo.
---
---@class Git
local Git = {}

---@return boolean: true if the cwd is in a git repo, false otherwise
function Git.in_repo()
  local f = function()
    local ok, _ = Bool.as_bool(System.run('git rev-parse --is-inside-work-tree'))
    return ok
  end

  return OnErr.return_false(f)
end


---@return string: the path to the root of the repo we're in currently
function Git.repo_root()
  return System.run('git rev-parse --show-toplevel')
end


---@return string|nil: the name of the repo we're in currently
function Git.repo_name()
  return Path.basename(Git.repo_root())
end


---@return string: the name of the active branch of the repo we're in currently
function Git.branch_name()
  return System.run('git rev-parse --abbrev-ref HEAD')
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

  InfoQuietly(
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


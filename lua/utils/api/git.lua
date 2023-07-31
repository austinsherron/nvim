local Bool   = require 'lib.lua.core.bool'
local String = require 'lib.lua.core.string'
local Path   = require 'lib.lua.system.path'
local System = require 'utils.api.vim.system'
local OnErr  = require 'utils.error.onerr'


--- Contains functions for interacting w/ git.
--
--  Note: most functions assume the cwd is in a git repo.
--
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


---@return string?: the name of the repo we're in currently
function Git.repo_name()
  return Path.basename(Git.repo_root())
end


---@return string: the name of the active branch of the repo we're in currently
function Git.branch_name()
  return System.run('git rev-parse --abbrev-ref HEAD')
end


--- Stages the file/files at the provided path.
--
---@param path string?: optional, defaults to "."; the path to stage
function Git.stage(path)
  System.run('git add ' .. (path or '.'))
end


--- Unstages the file/files at the provided path.
--
---@param path string?: optional, defaults to "."; the path to un-stage
function Git.unstage(path)
  System.run('git reset HEAD ' .. (path or '.'))
end


--- "Resets" (reverts) unstaged changes at the provided path.
--
---@param path string?: the path to reset; if nil or empty, no change will be affected
function Git.reset(path)
  if String.not_nil_or_empty(path) then
    System.run('git checkout -- ' .. path)
  end
end


--- Stashes changes in the working directory.
--
---@param msg string?: a description of the changes being stashed
function Git.stash(msg)
  local msg_arg = Bool.ternary(
    String.not_nil_or_empty(msg),
    function() return ' -m ' .. msg end,
    ''
  )
  System.run('git stash' .. msg_arg)
end

return Git


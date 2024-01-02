local Git = require 'utils.api.git'

local TreeNode = require('plugins.extensions.navigation').NvimTree.TreeNode


--- Contains functions that implement custom nvimtree-git integrations.
---
---@class TreeGit
local TreeGit = {}

local function path_for_git_op(all)
  return ternary(
    all,
    Git.repo_root(),
    TreeNode.at_cursor():getpath()
  )
end


--- Opens a diff view of the cursor node file(s).
function TreeGit.diffview()
  local path = Git.repo_path(path_for_git_op())

  require('diffview').open({ 'HEAD', '--', path })
end


--- Toggles the git staging status of the cursor node file(s).
function TreeGit.toggle_stage()
  local path = path_for_git_op()

  if Git.is_staged(path) then
    TreeGit.unstage()
  else
    TreeGit.stage()
  end
end


--- Stages the file(s) corresponding to the node under the cursor, or all files in the
--- repo if all is true.
---
---@param all boolean|nil: optional, defaults to false; if true, all modified files in the
--- current repo will be staged
function TreeGit.stage(all)
  all = Bool.or_default(all, false)

  Git.stage(path_for_git_op(all))
end


--- Unstages the file(s) corresponding to the node under the cursor, or all files in the
--- repo if all is true.
---
--@param all boolean|nil: optional, defaults to false; if true, all staged files in the
--- current repo will be unstaged
function TreeGit.unstage(all)
  all = Bool.or_default(all, false)

  Git.unstage(path_for_git_op(all))
end

return TreeGit


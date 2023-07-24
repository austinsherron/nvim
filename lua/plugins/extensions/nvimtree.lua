local Bool = require 'lib.lua.core.bool'
local Git  = require 'utils.api.git'


--- Contains methods for interacting w/ nvim-tree.
--
---@class NvimTree
---@field nvt_api table: the nvim-tree.api module
local NvimTree = {}
NvimTree.__index = NvimTree

--- Constructor
--
---@return NvimTree: a new NvimTree instance
function NvimTree.new()
  return setmetatable({}, NvimTree)
end


---@private
function NvimTree:api()
  if self.nvt_api == nil then
    self.nvt_api = require 'nvim-tree.api'
  end

  return self.nvt_api
end


--- Opens the nvim-tree window w/out changing focus from the tree buffer.
--
---@param node Node: the node to open silently
function NvimTree:silent_open(node)
  self:api().node.open.edit(node)
  self:api().tree.focus()
end


---@private
function NvimTree:is_tree_open()
  return self:api().tree.is_visible()
end


---@private
function NvimTree:cursor_node()
  return self:api().tree.get_node_under_cursor()
end


---@private
function NvimTree:is_tree_focused()
  return self:api().tree.is_tree_buf()
end


---@private
function NvimTree:tree_in_use()
  return self:is_tree_open() and self:is_tree_focused()
end


--- Returns the currently focused nvim-tree node. More precisely, it returns the node that
--  is currently under the cursor, if it exists. If focused is true, the nvim-tree buffer
--  must be both visible and active for a node to be returned; if focused is false, nvimtree
--  must only be visible. If the aforementioned conditions aren't met, this method returns
--  nil.
--
---@param focused boolean?: if true, the nvim-tree buffer must be both open and the active
-- buffer for a node to be considered "focused"; if false, it just hast to be open;
-- defaults to true
---@return Node?: the nvim-tree node that's currently under the cursor, if the conditions
-- mentioned above are met
function NvimTree:get_cursor_node(focused)
  focused = focused or true

   return Bool.ternary(
    (not focused and self:is_tree_open()) or (focused and self:tree_in_use()),
    function() return self:cursor_node() end,
    nil
  )
end


---@private
function NvimTree:path_for_git_op(all)
  return Bool.ternary(
    all,
    Git.repo_root(),
    self:get_cursor_node(true).absolute_path
  )
end


--- Stages the file(s) corresponding to the node under the cursor, or all files in the
--  repo if all is true.
--
---@param all boolean?: if true, all modified files in the current repo will be staged
function NvimTree:stage(all)
  Git.stage(self:path_for_git_op(all))
end


--- Unstages the file(s) corresponding to the node under the cursor, or all files in the
--  repo if all is true.
--
---@param all boolean?: if true, all staged files in the current repo will be unstaged
function NvimTree:unstage(all)
  Git.unstage(self:path_for_git_op(all))
end


--- Returns true if the provided node is non-nil and a dir node.
--
---@param node Node?: the node to check
---@return true: true if the provided node is non-nil and a dir node, false otherwise
function NvimTree.is_dir(node)
  return node ~= nil and node.type == 'directory'
end

return NvimTree.new()


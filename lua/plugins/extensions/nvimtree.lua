---@diagnostic disable: undefined-field

local File   = require 'toolbox.system.file'
local Lazy   = require 'toolbox.utils.lazy'
local Git    = require 'utils.api.git'
local Editor = require 'utils.api.vim.editor'

local api = Lazy.require 'nvim-tree.api'


--- Contains methods for interacting w/ nvim-tree.
---
---@class NvimTree
local NvimTree = {}

--- Copies into the system register the content of the file referenced by node.
---
---@param node Node: the node whose content will be copied
function NvimTree.copy_node_content(node)
  local node_path = NvimTree.get_node_path(node)

  if String.nil_or_empty(node_path) then
    return
  end

  if not NvimTree.is_file(node) then
    Warn('NvimTree ext: cannot copy content of node=%s: node is not a file node', { node.name })
    Debug('NvimTree ext: node=%s', { node })
    return
  end

  local content = File.read(node_path --[[@as string safe due to nil_or_empty call above]])
  Editor.copy(content or '')
end


--- Wrapper around NvimTree.copy_node_content that uses the cursor node.
---
---@see NvimTree.copy_node_content
---@see NvimTree.get_cursor_node
function NvimTree.copy_cursor_node_content()
  local node = NvimTree.get_cursor_node(true)

  if node == nil then
    return
  end

  NvimTree.copy_node_content(node)
end


--- Opens the nvim-tree window w/out changing focus from the tree buffer.
---
---@param node Node: the node to open silently
function NvimTree.silent_open(node)
  api.node.open.edit(node)
  api.tree.focus()
end


local function is_tree_open()
  return api.tree.is_visible()
end


local function cursor_node()
  return api.tree.get_node_under_cursor()
end


local function is_tree_focused()
  return api.tree.is_tree_buf()
end


local function tree_in_use()
  return is_tree_open() and is_tree_focused()
end


--- Returns the currently focused nvim-tree node. More precisely, it returns the node that
--- is currently under the cursor, if it exists. If focused is true, the nvim-tree buffer
--- must be both visible and active for a node to be returned; if focused is false, nvimtree
--- must only be visible. If the aforementioned conditions aren't met, this method returns
--- nil.
---
---@param focused boolean|nil: optional, defaults to true; if true, the nvim-tree buffer
--- must be both open and active be considered "focused"; if false, it just has to be open
---@return Node|nil: the nvim-tree node that's currently under the cursor, if the
--- conditions mentioned above are met
function NvimTree.get_cursor_node(focused)
  focused = Bool.or_default(focused, true)

   return ternary(
    (not focused and is_tree_open()) or (focused and tree_in_use()),
    function() return cursor_node() end,
    nil
  )
end


---@private
function NvimTree.path_for_git_op(all)
  return ternary(
    all,
    Git.repo_root(),
    NvimTree.get_node_path(NvimTree.get_cursor_node(true))
  )
end


--- Stages the file(s) corresponding to the node under the cursor, or all files in the
--- repo if all is true.
---
---@param all boolean|nil: optional, defaults to false; if true, all modified files in the
--- current repo will be staged
function NvimTree.stage(all)
  all = Bool.or_default(all, false)

  Git.stage(NvimTree.path_for_git_op(all))
end


--- Unstages the file(s) corresponding to the node under the cursor, or all files in the
--- repo if all is true.
---
--@param all boolean|nil: optional, defaults to false; if true, all staged files in the
--- current repo will be unstaged
function NvimTree.unstage(all)
  all = Bool.or_default(all, false)

  Git.unstage(NvimTree.path_for_git_op(all))
end


--- Returns true if the provided node is a dir node.
---
---@param node Node: the node to check
---@return true: true if the provided node is a dir node, false otherwise
function NvimTree.is_dir(node)
  return node.type == 'directory'
end


--- Returns true if the provided node is a file node.
---
---@param node Node: the node to check
---@return true: true if the provided node is a file node, false otherwise
function NvimTree.is_file(node)
  return node.type == 'file'
end


local function get_name(node)
  if node == nil then
    return '?'
  end

  return node.name
end


--- Returns the absolute_path of node.
---
---@param node Node|nil: the node whose absolute path will be returned, if it exists
---@return string|nil: the absolute path of node, or nil if none is present
function NvimTree.get_node_path(node)
  if node ~= nil and String.not_nil_or_empty(node.absolute_path) then
    return node.absolute_path
  end

  Warn('NvimTree ext: node=%s has no absolute_path', { get_name(node) })
  Debug('NvimTree ext: node=%s', { node })
end

return NvimTree


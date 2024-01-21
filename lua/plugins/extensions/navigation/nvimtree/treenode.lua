local Type = require 'toolbox.meta.type'
local Validate = require 'toolbox.utils.validate'

local api = Lazy.require 'nvim-tree.api' ---@module 'nvim-tree.api'

local function cursor_node()
  return api.tree.get_node_under_cursor()
end

local function is_tree_open()
  return api.tree.is_visible()
end

local function is_tree_focused()
  return api.tree.is_tree_buf()
end

local function tree_in_use()
  return is_tree_open() and is_tree_focused()
end

local EMPTY_NODE = { name = '?' }

---@alias NodeInfo { name: string, absolute_path: string, type: string, parent: NodeInfo|nil }

--- Models an nvimtree node.
---
--- WARN: this class is based on nvimtree impl; unfortunately, nvimtree doesn't seem to
--- define any classes or aliases to import.
---
---@class TreeNode
---@field name string: the name of the node, or '?' if the node is nil
---@field abspath string|nil: the absolute path of the file/dir referenced by the node
---@field type string|nil: the type of the node, "file" or "directory"
---@field parent NodeInfo|nil: the parent of the node, or nil if it doesn't have one
---@field node NodeInfo|nil: the nvimtree api node object that backs the instance
local TreeNode = {}
TreeNode.__index = TreeNode

--- Constructor
---
---@param node NodeInfo|nil: node info from nvimtree api
---@return TreeNode: a new instance
function TreeNode.new(node)
  if node == nil then
    return setmetatable(EMPTY_NODE, TreeNode)
  end

  Validate.required(node, { 'name', 'absolute_path', 'type' }, 'init TreeNode')
  local props = Table.pick(node, { 'name', 'absolute_path', 'type', 'parent' })

  Dict.rekey(props, 'absolute_path', 'abspath')
  props.node = node

  return setmetatable(props, TreeNode)
end

--- Returns the currently focused nvim-tree node. More precisely, it returns the node that
--- is currently under the cursor, if it exists. If focused is true, the nvim-tree buffer
--- must be both visible and active for a node to be returned; if focused is false, nvimtree
--- must only be visible. If the aforementioned conditions aren't met, this method returns
--- an empty tree node.
---
---@param focused boolean|nil: optional, defaults to true; if true, the nvim-tree buffer
--- must be both open and active be considered "focused"; if false, it just has to be open
---@return TreeNode: the nvim-tree node that's currently under the cursor, if the
--- conditions mentioned above are met, or an empty node otherwise
function TreeNode.at_cursor(focused)
  focused = Bool.or_default(focused, true)

  if (not focused and is_tree_open()) or (focused and tree_in_use()) then
    return TreeNode.new(cursor_node())
  end

  return TreeNode.new()
end

---@return boolean: true if this instance was constructed w/ a nil node info, false
--- otherwise
function TreeNode:empty()
  return self == EMPTY_NODE
end

---@error if abspath is nil
---@return string: the absolute path of the node
function TreeNode:getpath()
  if String.nil_or_empty(self.abspath) then
    Err.raise('TreeNode.getpath: node has no absolute path; node=%s', { self })
  end

  return self.abspath
end

---@return string: the absolute path of this node, if it's a dir, or the node's
--- parent's path otherwise
function TreeNode:nearestdir()
  if self:isdir() then
    return self:getpath()
  end

  return self:getparent():getpath()
end

---@return TreeNode: this node's parent
function TreeNode:getparent()
  return TreeNode.new(self.parent)
end

---@return boolean: true if this node is a dir node, false otherwise
function TreeNode:isdir()
  return self.type == 'directory'
end

---@return true: true if this node is a file node, false otherwise
function TreeNode:isfile()
  return self.type == 'file'
end

--- Checks if this instance equals o.
---
---@param o any|nil: the other instance to check
---@return boolean: true if this instance == o (i.e.: has the same key/value pairs), false
--- otherwise
function TreeNode:__eq(o)
  return Type.is(o, TreeNode) and self.name == o.name and self.abspath == o.abspath and self.type == o.type
end

local function append_if_not_nil(arr, attr, attrname)
  if attr ~= nil then
    Array.append(arr, fmt('%s=%s', attrname, attr))
  end
end

---@return string: a string representation of this instance
function TreeNode:__tostring()
  if self:empty() then
    return 'TreeNode()'
  end

  local strs = {}

  append_if_not_nil(strs, self.name, 'name')
  append_if_not_nil(strs, self.abspath, 'abspath')
  append_if_not_nil(strs, self.type, 'type')

  if self.parent ~= nil then
    append_if_not_nil(strs, self:getparent().name, 'parent')
  end

  return fmt('TreeNode(%s)', String.join(strs))
end

return TreeNode

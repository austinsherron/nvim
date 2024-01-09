---@diagnostic disable: undefined-field

local TreeNode = require 'plugins.extensions.navigation.nvimtree.treenode'
local File     = require 'toolbox.system.file'
local Lazy     = require 'toolbox.utils.lazy'
local Editor   = require 'utils.api.vim.editor'
local System   = require 'utils.api.vim.system'

local api = Lazy.require 'nvim-tree.api'


local LOGGER = GetLogger('EXT')

--- Contains functions that implement extended (custom) nvimtree functionality.
---
---@class TreeActions
local TreeActions = {}

--- Copies into the system register the content of the file referenced by the cursor node.
function TreeActions.copy_cursor_node_content()
  local node = TreeNode.at_cursor()

  if node:empty() then
    return
  end

  -- FIXME: this should probably use "not TreeNode:isfile", but that's not working and
  --        it's not immediately clear why
  if TreeNode:isdir() then
    LOGGER:warn('TreeActions: cannot copy content of node=%s, type="%s": not a file', { node.name, node.type })
    LOGGER:debug('TreeActions: node=%s', { node })
    return
  end

  local content = File.read(node:getpath())
  Editor.copy(content or '')

  LOGGER:info('Successfully copied to clipboard contents of %s', { node.name }, { user_facing = true })
end


--- Opens the cursor node file w/out changing focus from the tree buffer.
function TreeActions.silent_open()
  local node = TreeNode.at_cursor()

  if node:empty() then
    return
  end

  api.node.open.edit(node.node)
  api.tree.focus()
end


--- Adds executable file permissions to the file/dir referenced by the cursor node.
function TreeActions.chmod_x()
  local node = TreeNode.at_cursor()

  if node:empty() then
    return
  end

  System.chmod_x(node:getpath())
end

return TreeActions


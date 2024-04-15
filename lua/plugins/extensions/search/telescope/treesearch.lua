local ActionUtils = require 'plugins.extensions.search.telescope.actionutils'
local Path = require 'toolbox.system.path'
local TMerge = require 'utils.api.vim.tablemerge'

local TreeNode = require('plugins.extensions.navigation').NvimTree.TreeNode

local builtins = require 'telescope.builtin'

--- Contains functions that implement extended (custom) nvimtree telescope search
--- functionality. Current extensions include:
---
---   * Nvim-tree integration that enables contextual file search, i.e.: search
---     constrained to the cursor's directory while in nvim-tree
---   * Nvim-tree integration that enables contextual live grep, i.e.: live grep
---     constrained to the cursor's directory while in nvim-tree
---
---@class TreeSearch
local TreeSearch = {}

local function warn_for_missing_path(node)
  local msg = 'TreeSearch: no node path found for node=%s (likely searching '
    .. 'root node); falling back to non-contextual search'

  return GetLogger('EXT'):warn(msg, { node.name })
end

local function make_picker_title(title, node_path)
  return title .. ' (in ' .. Path.basename(node_path) .. ')'
end

--- Executes a search function constrained to the nvimtree dir under the cursor, or the
--- parent dir of the file under the cursor, if any. Otherwise, executes an unconstrained
--- search.
---
---@generic T
---@param f fun(opts: table): T telescope picker function to execute
---@param title string: the base title of the picker
---@param opts table|nil: optional; table of options passed to telescope
---@return T: the return value of f
function TreeSearch.do_contextual_search(f, title, opts)
  opts = TMerge.mergeleft({ prompt_title = title }, opts or {})
  local node = TreeNode.at_cursor()

  if node:empty() or node:isroot() then
    return f(opts)
  end

  local node_path = node:nearestdir()

  if node_path == nil then
    warn_for_missing_path(node)
    return f(opts)
  end

  opts = TMerge.mergeleft({
    cwd = node_path,
    prompt_title = make_picker_title(title, node_path),
  }, opts)

  return f(opts)
end

--- Calls Telescope.do_contextual_search w/ the `find_files` telescope builtin.
---
---@see telescope.builtins.find_files
---@param opts { hidden: boolean, no_ignore: boolean, no_ignore_parent: boolean }:
--- options to pass to telescope finder; can include more than just the values specified
--- above
function TreeSearch.contextual_find_files(opts)
  return TreeSearch.do_contextual_search(builtins.find_files, 'Find Files', opts)
end

--- Same as Telescope.contextual_find_files but includes all hidden files in the search.
---
---@see Telescope.contextual_find_files
function TreeSearch.contextual_find_all_files()
  return TreeSearch.contextual_find_files(ActionUtils.Constants.FIND_ALL_FILES_OPTS)
end

--- Calls Telescope.do_contextual_search w/ the `live_grep` telescope builtin.
---
---@see telescope.builtins.live_grep
---@param opts table|nil: options to pass to telescope finder; optional
function TreeSearch.contextual_live_grep(opts)
  return TreeSearch.do_contextual_search(builtins.live_grep, 'Live Grep', opts)
end

--- Same as Telescope.contextual_live_grep but includes all hidden files in the search.
---
---@see telescope.builtins.live_grep
function TreeSearch.contextual_live_grep_all_files()
  return TreeSearch.do_contextual_search(
    builtins.live_grep,
    'Live Grep (All Files)',
    ActionUtils.Constants.FIND_ALL_FILES_OPTS
  )
end

return TreeSearch

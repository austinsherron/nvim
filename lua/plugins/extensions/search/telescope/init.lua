local NvTree         = require 'plugins.extensions.navigation.nvimtree'
local TelescopeUtils = require 'plugins.extensions.search.telescope.utils'
local Env            = require 'toolbox.system.env'
local Path           = require 'toolbox.system.path'
local TMerge         = require 'utils.api.vim.tablemerge'

local builtins = require 'telescope.builtin'


---@alias TelescopeKeyBinding { mode: string, key: string, action: string|function }
---@alias TelescopeKeyMapper fun(mode: string|string[], key: string, action: string|function)
---@alias TelescopeAttachBindings fun(prompt_buffer: integer, map: TelescopeKeyMapper): boolean

--- Contains functions that implement extended (custom) telescope search functionality.
--- Current extensions include:
---
---   * Nvim-tree integration that enables contextual file search, i.e.: search
---     constrained to the cursor's directory while in nvim-tree
---   * Nvim-tree integration that enables contextual live grep, i.e.: live grep
---     constrained to the cursor's directory while in nvim-tree
---   * A custom picker that searches for nvim plugin packages and enables drill-down
---     file search on selected packages
---
---@class Telescope
local Telescope = {}

local function make_missing_node_path_msg(node)
  return 'Telescope ext: no node path found for node=%s (likely searching root node); falling back to non-contextual search', { node.name }
end


--- Executes a search function constrained to the nvimtree dir under the cursor, or the
--- parent dir of the file under the cursor, if any. Otherwise, executes an unconstrained
--- search.
---
---@param f function: telescope picker function to execute
---@param title string: the base title of the picker
---@param opts table|nil: table of options passed to telescope; optional, defaults to
--- empty table
---@return any|nil: the return value of f
function Telescope.do_contextual_search(f, title, opts)
  opts = TMerge.mergeleft({ prompt_title = title }, opts or {})
  local node = NvTree.get_cursor_node()

  if node == nil then
    return f(opts)
  end

  local node_path = ternary(
    NvTree.is_file(node),
    function() return NvTree.get_node_path(node.parent) end,
    NvTree.get_node_path(node)
  )

  if node_path == nil then
    Warn(make_missing_node_path_msg(node))
    Debug('Telescope ext: node=%s', { node })
    return f(opts)
  end

  opts = TMerge.mergeleft({
    cwd          = node_path,
    prompt_title = title .. ' (in ' .. Path.basename(node_path) .. ')'
  }, opts)

  return f(opts)
end


--- Calls Telescope.do_contextual_search w/ the `find_files` telescope builtin.
---
---@see telescope.builtins.find_files
---@param opts { hidden: boolean, no_ignore: boolean, no_ignore_parent: boolean }:
--- options to pass to telescope finder; can include more than just the values specified
--- above
function Telescope.contextual_find_files(opts)
  return Telescope.do_contextual_search(builtins.find_files, 'Find Files', opts)
end


--- Same as Telescope.contextual_find_files but includes all hidden files in the search.
---
---@see Telescope.contextual_find_files
function Telescope.contextual_find_all_files()
  return Telescope.contextual_find_files({
    hidden           = true,
    no_ignore        = true,
    no_ignore_parent = true,
})
end


--- Calls Telescope.do_contextual_search w/ the `live_grep` telescope builtin.
---
---@see telescope.builtins.live_grep
---@param opts table|nil: options to pass to telescope finder; optional
function Telescope.contextual_live_grep(opts)
  return Telescope.do_contextual_search(builtins.live_grep, 'Live Grep', opts)
end


local function make_packages_live_grep_action()
  return TelescopeUtils.make_new_action(
    function(selection)
      local plugin_path = selection[1]

      builtins.live_grep({
        cwd          = plugin_path,
        prompt_title = 'Live Grep in ' .. Path.basename(plugin_path) .. ' plugin files'
      })
    end
  )
end


local function search_package_files_action(selection)
  local plugin_path = selection[1]

  builtins.find_files({
    cwd          = plugin_path,
    prompt_title = 'Search ' .. Path.basename(plugin_path) .. ' plugin files'
  })
end


local function make_keymap()
  return {
    { 'i', '<C-w>', make_packages_live_grep_action() },
    { 'n', 'fw',    make_packages_live_grep_action() },
  }
end


local function make_attachment_action()
  return TelescopeUtils.make_new_action(
    Safe.ify(search_package_files_action),
    make_keymap()
  )
end


--- Custom telescope picker for searching "nvundle" (i.e.: plugin directories).
function Telescope.search_packages()
  local find_command = { 'find', Env.nvundle(), '-maxdepth',  '1', '-type', 'd' }

  builtins.find_files({
    attach_mappings = make_attachment_action(),
    find_command    = find_command,
    path_display    = function(_, path) return Path.basename(path) end,
    prompt_title    = 'Search Plugins',
  })
end

return Telescope


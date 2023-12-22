local NvTree = require 'plugins.extensions.nvimtree'
local Env    = require 'toolbox.system.env'
local Path   = require 'toolbox.system.path'
local TMerge = require 'utils.api.vim.tablemerge'

-- for building telescope pickers
local actions      = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local builtins     = require 'telescope.builtin'

-- local conf         = require('telescope.config').values
-- local finders      = require 'telescope.finders'
-- local make_entry   = require 'telescope.make_entry'
-- local pickers      = require 'telescope.pickers'
-- local previewers   = require 'telescope.previewers'


---@alias TelescopeKeyBinding { mode: string, key: string, action: string|function }
---@alias TelescopeKeyMapper fun(mode: string|string[], key: string, action: string|function)
---@alias TelescopeAttachBindings fun(prompt_buffer: integer, map: TelescopeKeyMapper): boolean

--- Contains functions that implement extended (custom) telescope search functionality.
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


local function bind_keymap(keymap, map)
    keymap = keymap or {}

    for _, binding in ipairs(keymap) do
      if #binding ~= 3 then
        Warn('Telescope ext: discarding invalid key binding=%s', { binding })
      else
        map(Table.unpack(binding))
      end
    end
end


--- Utility for attaching key bindings to a picker w/out changing its default action.
---
---@param keymap TelescopeKeyBinding[]|nil: optional; picker action key bindings
---@param retval boolean|nil: optional, defaults to true; the return value of the returned
--- function; see :h telescope.mappings for details
---@return TelescopeAttachBindings: function that attaches key bindings to a picker and
--- returns retval
function Telescope.bind_keymap(keymap, retval)
  retval = Bool.or_default(retval, true)

  return function(_, map)
    bind_keymap(keymap, map)
    return retval
  end
end


--- Utility that makes it easier to replace an existing picker's default action.
---
---@param new_action fun(selection: table) a function that performs some action w/ the
--- selected telescope item
---@param keymap TelescopeKeyBinding[]|nil: optional; picker action key bindings
---@param retval boolean|nil: optional, defaults to true; the return value of the returned
--- function; see :h telescope.mappings for details
---@return (fun(pb: integer, _: any): r: true): a function used w/ telescope opts.attach_mappings
--- to replace an existing picker's default action
function Telescope.make_new_action(new_action, keymap, retval)
  retval = Bool.or_default(retval, true)

  return function(prompt_buffer, map)
    bind_keymap(keymap, map)

    actions.select_default:replace(
      function()
        actions.close(prompt_buffer)
        local selection = action_state.get_selected_entry()
        new_action(selection)
      end
    )

    return retval
  end
end


--- Creates a function intended for use w/ custom picker key bindings.
---
---@param confirm fun(s: { value: string }, pb: integer): c: boolean: a function that,
--- given the prompt selection and buffer id, returns true if we should continue; intended
--- for use asking users if they're sure they want to do something, etc.; can minimally
--- return true
---@param action fun(s: { value: string}, pb: integer): e: string: a function that
--- performs some action w/ the selected value; takes the selection and prompt buffer id as
--- arguments and returns an error string if an error was encountered during the action
---@param after (fun(e: string|nil, s: { value: string}, pb: integer))|nil: n: nil: a function
--- that runs after the primary action; intended for error processing, cleanup, etc.
---@return fun(pb: integer): n: nil: a function that performs some action when bound in a
--- picker keymap
function Telescope.make_selection_action(confirm, action, after)
  return function(prompt_buffer)
    local selection = action_state.get_selected_entry()

    if selection == nil then
      return actions.close(prompt_buffer)
    end

    if not confirm(selection, prompt_buffer) then
      return
    end

    local err = action(selection, prompt_buffer)

    if after ~= nil then
      after(err, selection, prompt_buffer)
    end
  end
end


local function make_search_packages_action()
  return Telescope.make_new_action(
    function(selection)
      local plugin_path = selection[1]

      builtins.find_files({
        cwd          = plugin_path,
        prompt_title = 'Search ' .. Path.basename(plugin_path) .. ' plugin files'
      })
    end
  )
end


--- Custom telescope picker for searching "nvundle" (i.e.: plugin directories).
function Telescope.search_packages()
  local find_command = { 'find', Env.nvundle(), '-maxdepth',  '1', '-type', 'd' }

  builtins.find_files({
    attach_mappings = make_search_packages_action(),
    find_command    = find_command,
    path_display    = function(_, path) return Path.basename(path) end,
    prompt_title    = 'Search Plugins',
  })
end

return Telescope


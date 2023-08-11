local NvTree   = require 'plugins.extensions.nvimtree'
local Builtins = require 'telescope.builtin'
local Env      = require 'toolbox.system.env'
local Path     = require 'toolbox.system.path'

-- for building telescope pickers
local actions      = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local conf         = require('telescope.config').values
local finders      = require 'telescope.finders'
local make_entry   = require "telescope.make_entry"
local pickers      = require 'telescope.pickers'
local previewers   = require 'telescope.previewers'


--- Contains functions that implement extended (custom) telescope search functionality.
---
---@class Telescope
local Telescope = {}

--- Executes a search function constrained to the nvimtree dir under the cursor, or the
--- parent dir of the file under the cursor, if any. Otherwise, executes an unconstrained
--- search.
---
---@param f function: telescope picker function to execute
---@return any?: the return value of f
function Telescope.do_contextual_search(f, title)
  local opts = { prompt_title = title }
  local node = NvTree:get_cursor_node()

  if node == nil then
    return f(opts)
  end

  local node_path = nil

  if NvTree.is_dir(node) then
    node_path = node.absolute_path
  elseif NvTree.is_file(node) then
    node_path = node.parent.absolute_path
  else
    error('nvim-tree <-> telescope integration: unrecognized nvim-tree node type=' .. node.type)
  end

  opts = {
    cwd          = node_path,
    prompt_title = title .. ' (in ' .. Path.basename(node_path) .. ')'
  }

  return f(opts)
end


--- Calls do_contextual_search w/ the `find_files` telescope builtin.
---
---@see telescope.builtins.find_files
function Telescope.contextual_find_files()
  return Telescope.do_contextual_search(Builtins.find_files, 'Find Files')
end


--- Calls do_contextual_search w/ the `live_grep` telescope builtin.
---
---@see telescope.builtins.live_grep
function Telescope.contextual_live_grep()
  return Telescope.do_contextual_search(Builtins.live_grep, 'Live Grep')
end


local function bind_keymap(keymap, map)
    keymap = keymap or {}

    for _, binding in ipairs(keymap) do
      if #binding ~= 3 then
        Warn({ 'Telescope ext: discarding invalid key binding=', binding })
      else
        map(Table.unpack(binding))
      end
    end
end


--- Utility that makes it easier to replace an existing picker's default action.
---
---@param new_action fun(s: string[]): n: nil: a function that takes an array w/ the
--- selected telescope item and performs some action w/ it
---@param keymap table[]?: an array-like table of array-like tables that contain picker
--- key bindings in the following format: { mode: string, key: string, action: string|function }
---@return (fun(pb: integer, _: any): r: true): a function used w/ telescope opts.attach_mappings
--- to replace an existing picker's default action
function Telescope.make_new_action(new_action, keymap)
  return function(prompt_buffer, map)
    bind_keymap(keymap, map)

    actions.select_default:replace(
      function()
        actions.close(prompt_buffer)
        local selection = action_state.get_selected_entry()
        new_action(selection)
      end
    )

    return true
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
---@param after (fun(e: string?, s: { value: string}, pb: integer))?: n: nil: a function
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

      Builtins.find_files({
        cwd          = plugin_path,
        prompt_title = 'Search ' .. Path.basename(plugin_path) .. ' plugin files'
      })
    end
  )
end


--- Custom telescope picker for searching "nvundle" (i.e.: plugin directories).
function Telescope.search_packages()
  local find_command = { 'find', Env.nvundle(), '-maxdepth',  '1', '-type', 'd' }

  Builtins.find_files({
    attach_mappings = make_search_packages_action(),
    find_command    = find_command,
    path_display    = function(_, path) return Path.basename(path) end,
    prompt_title    = 'Search Plugins',
  })
end

return Telescope


local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'

---@alias TelescopeKeyBinding { mode: string, key: string, action: string|function }
---@alias TelescopeKeyMapper fun(mode: string|string[], key: string, action: string|function)
---@alias TelescopeAttachBindings fun(prompt_buffer: integer, map: TelescopeKeyMapper): boolean
---@alias TelescopeAction fun(selected: table, prompt_buffer: integer): boolean
---@alias TelescopeAfterSelectFn fun(e: string|nil, s: { value: string }, pb: integer)

--- Contains utilities that abstract away some of the boilerplate of building and
--- customizing telescope search constructs.
---
---@class ActionUtils
local ActionUtils = {}

--- Contains predefined and utils for constructing functions for use after a selection
--- action.
---
---@class AfterSelect
local AfterSelect = {}

--- Closes the prompt buffer.
---@type TelescopeAfterSelectFn
function AfterSelect.close_prompt(_, _, prompt_buffer)
  actions.close(prompt_buffer)
end

--- Constructs a TelescopeAfterSelectFn that refreshes the prompt using the provided
--- finder.
---
---@param finder fun(): table function that returns a telescope finder for refreshed
--- results
---@return TelescopeAfterSelectFn: a function that refreshes the prompt using the provided
--- finder
function AfterSelect.refresh_prompt(finder)
  return function(_, _, prompt_buffer)
    local picker = action_state.get_current_picker(prompt_buffer)
    picker:refresh(finder(), { reset_prompt = true })
  end
end

--- Creates a function intended for use w/ custom picker key bindings.
---
---@param confirm fun(s: { value: string }, pb: integer): c: boolean: a function that,
--- given the prompt selection and buffer id, returns true if we should continue; intended
--- for use asking users if they're sure they want to do something, etc.; can minimally
--- return true
---@param action fun(s: { value: string}, pb: integer): e: string: a function that
--- performs some action w/ the selected value; takes the selection and prompt buffer id
--- as arguments and returns an error string if an error was encountered during the
--- action
---@param after (TelescopeAfterSelectFn)|nil: n: nil: a function that runs after the
--- primary action; intended for error processing, cleanup, etc.
---@return fun(selection: any, pb: integer): n: nil: a function that performs some action
--- when bound in a picker keymap
function ActionUtils.make_selection_action(confirm, action, after)
  return function(selection, prompt_buffer)
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

local function bind_keymap(keymap, map)
  keymap = keymap or {}

  for _, binding in ipairs(keymap) do
    if #binding ~= 3 then
      GetLogger('EXT'):warn('Telescope: discarding invalid key binding=%s', { binding })
    else
      binding[3] = ActionUtils.make_action(binding[3])
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
function ActionUtils.bind_keymap(keymap, retval)
  retval = Bool.or_default(retval, true)

  return function(_, map)
    bind_keymap(keymap, map)
    return retval
  end
end

--- Wraps a function for use as a picker action.
---
---@param action TelescopeAction: the function to wrap
---@return fun(bufnr: integer): boolean a function wrapped for use as a picker action
function ActionUtils.make_action(action)
  return function(bufnr)
    local selected = action_state.get_selected_entry()
    return action(selected, bufnr)
  end
end

--- Utility that makes it easier to replace an existing picker's default action.
---
---@param new_action fun(selection: table) a function that performs some action w/ the
--- selected telescope item
---@param keymap TelescopeKeyBinding[]|nil: optional; picker action key bindings
---@param retval boolean|nil: optional, defaults to true; the return value of the returned
--- function; see :h telescope.mappings for details
---@return (fun(pb: integer, _: any): r: true): a function used w/ telescope
--- opts.attach_mappings to replace an existing picker's default action
function ActionUtils.replace_default_action(new_action, keymap, retval)
  retval = Bool.or_default(retval, true)

  return function(prompt_buffer, map)
    bind_keymap(keymap, map)

    actions.select_default:replace(function()
      actions.close(prompt_buffer)
      local selection = action_state.get_selected_entry()
      new_action(selection)
    end)

    return retval
  end
end

---@note: so AfterSelect is publicly exposed
ActionUtils.AfterSelect = AfterSelect
-- Generally useful constants.
ActionUtils.Constants = {
  -- When passed to builtins.find_files, performs search on hidden and ignored files.
  FIND_ALL_FILES_OPTS = {
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
  },
}

return ActionUtils

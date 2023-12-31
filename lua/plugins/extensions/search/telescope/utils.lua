local actions      = require 'telescope.actions'
local action_state = require 'telescope.actions.state'


--- Contains utilities that abstract away some of the boilerplate of building and
--- customizing telescope search constructs.
---
---@class TelescopeUtils
local TelescopeUtils = {}

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
function TelescopeUtils.bind_keymap(keymap, retval)
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
function TelescopeUtils.make_new_action(new_action, keymap, retval)
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
function TelescopeUtils.make_selection_action(confirm, action, after)
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

return TelescopeUtils


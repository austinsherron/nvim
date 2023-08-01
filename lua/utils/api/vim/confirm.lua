local Stream = require 'lib.lua.extensions.stream'

local confirm = vim.fn.confirm


local DEFAULT_CHOICES   = { 'yes', 'no' }
local DEFAULT_CHOICE    = 2
local DEFAULT_CONFIRMED = function(ci) return ci == 1 end

--- Contains utilities for interacting w/ the vim.fn.confirm api, i.e.: creating and
--- interacting w/ confirmation dialogs.
---
---@class Confirm
local Confirm = {}

--- Formats an array-like table of choices in the manner expected by the confirm api.
---
---@param choices string[]: the choices to format
---@return string: a string of choices formatted in the manner expected by the confirm api
function Confirm.fmt_choices(choices)
  return Stream(choices)
    :map(String.capitalize)
    :map(function(c) return '&' .. c end)
    :collect(function(cs) return String.join(cs, '\n') end)
end


--- Constructs a confirmation dialog.
---
---@param msg string: the confirmation message
---@param choices string[]?: possible choices; optional, defaults to { yes, no }
---@param default_choice integer?: index of the default choice; optional, defaults to 2
--- ("no", w/ default choices)
---@param confirmed (fun(ci: integer): o: boolean)?: function that takes as an argument the
--- index of the selected choice and returns true if that choice indicates confirmation;
--- optional, defaults to a function that returns ci == 1 (choice == "yes", w/ default
--- choices)
---@return boolean: the return value of confirmed: true if confirmed, false otherwise
function Confirm.dialog(msg, choices, default_choice, confirmed)
  choices = choices or DEFAULT_CHOICES
  default_choice = default_choice or DEFAULT_CHOICE
  confirmed = confirmed or DEFAULT_CONFIRMED

  local choices_str = Confirm.fmt_choices(choices)
  local choice = confirm(msg, choices_str, default_choice)
  return confirmed(choice)
end

return Confirm


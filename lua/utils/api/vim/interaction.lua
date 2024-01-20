local confirm = vim.fn.confirm

local KEYBOARD_INT = 'Keyboard interrupt'
local DEFAULT_CHOICES = { 'yes', 'no' }
local DEFAULT_CHOICE = 2
local DEFAULT_CONFIRMED = function(ci)
  return ci == 1
end

--- Contains utilities that make it easier to work w/ (n)vim's interaction api, i.e.:
--- vim.fn.confirm api for creating and interacting w/ confirmation dialogs, vim.fn.input
--- for input boxes, etc.
---
---@class Interaction
local Interaction = {}

local function is_forcequit(res)
  return res == KEYBOARD_INT
end

local function handle_input_success(ok, res, required)
  if required and String.nil_or_empty(res) then
    Notify.warn 'Input is required'
  end

  return not ok, ternary(String.not_nil_or_empty(res), res)
end

local function callinput(opts, required)
  local ok, res = pcall(vim.fn.input, opts)

  if ok then
    return handle_input_success(ok, res, required)
  elseif not is_forcequit(res) then
    Err.raise('Interaction: error encountered processing input: %s', res)
  else
    return not ok, nil
  end
end

--- Wrapper around vim.fn.input that adds "requiredness" functionality. If opts.require ==
--- true, a warning is propagated and the dialog persists until the user either enters a
--- non-empty string or cancels via keyboard interrupt.
---
---@param prompt string: the input dialog's prompt text
---@param opts table|nil: optional; same as opts described in :h input() except prompt is
--- superseded by the above prompt argument, and a "required" option, described above, can
--- be included
---@return string|nil: the user input string, or nil if it was empty/the user canceled
---@return boolean: true if the user canceled, false otherwise
function Interaction.input(prompt, opts)
  local required, rest = Table.split_one(opts or {}, 'required')
  opts = Table.combine(rest, { prompt = prompt })

  local forcequit, input = callinput(opts, required)

  while input == nil and required and not forcequit do
    forcequit, input = callinput(opts, required)
  end

  return input, forcequit
end

--- Formats an array-like table of choices in the manner expected by the confirm api.
---
---@param choices string[]: the choices to format
---@return string: a string of choices formatted in the manner expected by the confirm api
function Interaction.fmt_choices(choices)
  return Stream.new(choices)
    :map(String.capitalize)
    :map(function(c)
      return '&' .. c
    end)
    :collect(function(cs)
      return String.join(cs, '\n')
    end)
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
function Interaction.confirmation_dialog(msg, choices, default_choice, confirmed)
  choices = choices or DEFAULT_CHOICES
  default_choice = default_choice or DEFAULT_CHOICE
  confirmed = confirmed or DEFAULT_CONFIRMED

  local choices_str = Interaction.fmt_choices(choices)
  local choice = confirm(msg, choices_str, default_choice)
  return confirmed(choice)
end

return Interaction

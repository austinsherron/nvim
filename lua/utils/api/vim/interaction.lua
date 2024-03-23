local KeyMapper = require 'utils.core.mapper'

local menu = require 'nui.menu'

local confirm = vim.fn.confirm

local QUIT_CHOICE = '__quit__'
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

local function handle_input_success(ok, res, custom)
  local required = custom.required
  local default = custom.default

  if required and String.nil_or_empty(res) and String.nil_or_empty(default) then
    GetNotify().warn 'Input is required'
  end

  return not ok, ternary(String.not_nil_or_empty(res), res, default)
end

local function callinput(opts, custom)
  local ok, res = pcall(vim.fn.input, opts)

  if ok then
    return handle_input_success(ok, res, custom)
  elseif not is_forcequit(res) then
    Err.raise('Interaction: error encountered processing input: %s', res)
  else
    return not ok, nil
  end
end

local function make_prompt(prompt, custom)
  if custom.nofmt == true then
    return prompt
  end

  local final_prompt = fmt('%s: ', String.capitalize(prompt))

  if String.nil_or_empty(custom.default) then
    return final_prompt
  end

  return fmt('%s(default = %s) ', final_prompt, custom.default)
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
  local custom, rest = Table.split(opts or {}, { 'required', 'default', 'nofmt' })
  opts = Table.combine(rest, { prompt = make_prompt(prompt, custom) })

  local forcequit, input = callinput(opts, custom)

  while input == nil and custom.required and not forcequit do
    forcequit, input = callinput(opts, custom)
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
---@param confirmed (fun(ci: integer): o: boolean)?: function that takes as an argument
--- the index of the selected choice and returns true if that choice indicates
--- confirmation; optional, defaults to a function that returns ci == 1 (choice == "yes",
--- w/ default choices)
---@return boolean: the return value of confirmed: true if confirmed, false otherwise
function Interaction.confirmation_dialog(msg, choices, default_choice, confirmed)
  choices = choices or DEFAULT_CHOICES
  default_choice = default_choice or DEFAULT_CHOICE
  confirmed = confirmed or DEFAULT_CONFIRMED

  local choices_str = Interaction.fmt_choices(choices)
  local choice = confirm(msg, choices_str, default_choice)
  return confirmed(choice)
end

local POPUP_OPTIONS = {
  relative = 'cursor',
  position = {
    row = 2,
    col = 2,
  },
  border = {
    style = 'rounded',
    highlight = 'FloatBorder',
    text = {
      top_align = 'center',
    },
  },
  highlight = 'Normal:Normal',
}

local KEYMAP = {
  focus_next = { 'j', '<Down>', '<Tab>' },
  focus_prev = { 'k', '<Up>', '<S-Tab>' },
  close = { '<Esc>', '<C-c>' },
  submit = { '<CR>' },
}

local SEP = {
  char = '─',
  text_align = 'center',
}

-- TODO: refactor to "ui/cursor/etc." vim api
local function get_row()
  local cursor_line = vim.fn.line '.'
  local first_line = vim.fn.line 'w0'
  local fold = { up = -7, down = 2 }

  local height = vim.fn.winheight(0)
  local diff_start = cursor_line - first_line

  local remaining_space = height - (diff_start + 1)

  if remaining_space < 9 then
    return fold.up
  end

  return fold.down
end

local function get_max_len(title, choices)
  return Stream.new(Array.appended(choices, title))
    :map(String.len)
    :collect(Stream.Collectors.max())
end

local function make_menu_choice(i, choice, max_len, value)
  value = value or choice
  choice = String.rpad(choice, ' ', max_len)

  return menu.item(fmt('%s) %s', i, choice), { value = value })
end

local function update_keymap(key, pos, keymap)
  keymap[tostring(key)] = pos .. 'G'
end

local function make_quit_choice(menu_choices, max_len, keymap)
  local quit_choice = make_menu_choice('q', 'quit', max_len, QUIT_CHOICE)
  update_keymap('q', Array.len(menu_choices) + 2, keymap)

  return quit_choice
end

local function make_menu_choices(choices, max_len)
  local menu_choices = {}
  local keymap = {}

  for i, choice in ipairs(choices) do
    local menu_choice = make_menu_choice(i, choice, max_len)
    Array.append(menu_choices, menu_choice)
    update_keymap(i, i, keymap)
  end

  local quit_choice = make_quit_choice(menu_choices, max_len, keymap)

  Array.append(menu_choices, menu.separator '')
  Array.append(menu_choices, quit_choice)

  return menu_choices, keymap
end

local function make_bindings(keymap)
  local bindings = {}

  for key, action in pairs(keymap) do
    Array.append(bindings, { key, action, {}, { 'i' } }, {})
  end

  return bindings
end

local function make_submit_handler(submit)
  return function(selection)
    return submit(ternary(selection.value ~= QUIT_CHOICE, selection.value))
  end
end

local function remove_bindings(mapper, bindings)
  local toremove = map(bindings, function(b)
    Array.remove_at(b, 2)
    return b
  end)

  mapper:reset(toremove)
end

--- Constructs a selection dialog.
---
---@param title string: the dialog's title
---@param choices string[]: possible choices
---@param submit fun(selection: string|nil): any|nil: function to call on submit;
--- selection == nil if "quit" is selected
function Interaction.selection_dialog(title, choices, submit)
  POPUP_OPTIONS.position.row = get_row()
  POPUP_OPTIONS.border.text.top = String.capitalize(title)

  local max_len = get_max_len(title, choices)
  local menu_choices, keymap = make_menu_choices(choices, max_len)

  local mapper = KeyMapper.new({ noremap = false, nowait = true, buffer = menu.bufnr })
  local bindings = make_bindings(keymap)

  local dialog = menu(POPUP_OPTIONS, {
    size = { width = 50 },
    lines = menu_choices,
    separator = SEP,
    keymap = KEYMAP,
    on_submit = make_submit_handler(submit),
    on_close = function()
      remove_bindings(mapper, bindings)
    end,
  })

  mapper:bind(bindings)
  dialog:mount()
end

return Interaction

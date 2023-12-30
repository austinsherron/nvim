local Num  = require 'toolbox.core.num'
local Iter = require 'toolbox.utils.iter'

local map = require('toolbox.utils.map').map


local Constants = {}

--- A dummy key binding that indicates to formatter that a vertical break should be added
--- to a menu in its place.
Constants.VERTICAL_BREAK = { '', '', { desc = 'VERTICAL_BREAK' }}
--- A binding that indicates to hydra that a menu should map exit to "<Esc>".
Constants.ESC_BINDING = {'<Esc>', nil, { desc = 'Exit' }}

--- A private helper class used to format key binding menus.
---
---@class Menu
---@field private name string|nil: the name of the binding group; used as a title if
--- present
---@field private bindings Binding[]: the bindings for which to construct a menu
---@field private columns string[][]: interim state; array of arrays representing menu
--- columns
---@field private rows string[]: interim state; array of strings representing rows
---@field private col_widths integer[]: interim state; the maximum width of each column;
--- used for alignment
---@field private max_lhs integer: interim state; the maximum width of any lhs in
--- bindings; used for alignment
---@field private row_width integer: interim state; the maximum width of any row in rows;
--- used for alignment
---@field private escape Binding|nil: interim state; the escape binding, if found in
--- bindings
local Menu = {}
Menu.__index = Menu

--- Constructor
---
---@param bindings Binding[]: the bindings for which to construct a menu
---@param numcols integer: the number of columns the help string should have
---@param name string|nil: optional; the name of the binding group; used as a title if
--- present
---@return Menu: a new instance
function Menu.new(bindings, numcols, name)
  return setmetatable({
    name       = name,
    bindings   = bindings,
    columns    = Array.fill({}, numcols),
    rows       = {},
    col_widths = Array.fill(-1, numcols),
    max_lhs    = Num.max(Table.unpack(map(bindings, function(b) return #b[1] end))),
    row_width  = -1,
    escape     = nil,
  }, Menu)
end


---@private
function Menu:has_escape()
  return self.escape ~= nil
end


---@private
function Menu:get_row(idx)
  local row = {}

  for i, column in ipairs(self.columns) do
    local cell = Table.safeget(column, idx)

    if cell ~= nil then
      local len = self.col_widths[i]
      Array.append(row, String.rpad(cell, ' ', len + 4))
    end
  end

  return row
end


---@private
function Menu:init_rows()
  for i = 1, #self.columns[1] do
    local row = self:get_row(i)
    local rowstr = String.join(row, '')

    self.row_width = Num.max(self.row_width, #rowstr)
    Array.append(self.rows, rowstr)
  end
end


---@private
function Menu:make_binding_string(binding)
  if Constants.VERTICAL_BREAK == binding then
    return ''
  end

  local lhs = fmt('_%s_:', binding[1])
  local rhs = binding[2]
  local desc = Table.safeget(binding, { 3, 'desc' }) or rhs

  return fmt('%s %s', String.rpad(lhs, ' ', self.max_lhs), desc)
end


---@private
function Menu:init_columns()
  local col_iter = Iter.circular(#self.columns)

  for _, binding in ipairs(self.bindings) do
    if Constants.ESC_BINDING == binding then
      self.escape = binding
      goto continue
    end

    local idx = col_iter()
    local col = self.columns[idx]
    local entry = self:make_binding_string(binding)

    Array.append(col, entry)
    self.col_widths[idx] = Num.max(#entry, self.col_widths[idx])

    ::continue::
  end
end


---@private
function Menu:format_title()
  local title = String.cpad(self.name, ' ', self.row_width)
  self.rows = Table.concat({{ title, '' }, self.rows })
end


---@private
function Menu:format_escape()
  local entry = self:make_binding_string(self.escape)
  local esc_row = String.lpad(entry, ' ', self.row_width)

  self.rows = Table.concat({ self.rows, { '', esc_row }})
end


---@package
function Menu:format()
  self:init_columns()
  self:init_rows()

  if self.name ~= nil then
    self:format_title()
  end

  if self:has_escape() then
    self:format_escape()
  end

  return String.join(self.rows, '\n')
end

--- Contains utilities for formatting key binding help menus.
---
---@class MenuFormatter
local MenuFormatter = {}

--- Creates a formatted help string (or "hint" string, in hydra.nvim parlance) from an
--- array of key bindings. For example:
---
---   MenuFormatter.format({
---     { 'j', ':resize -2<CR>',           { desc = 'resize down'  }},
---     { 'k', ':resize +2'<CR>,           { desc = 'resize up'    }},
---     { 'l', ':vertical resize +2<CR>',  { desc = 'resize right' }},
---     { 'h', ':vertical resize -2<CR>',  { desc = 'resize left'  }},
---   }) -> [[
---         j: resize down   k: resize up
---         l: resize right  h: resize left
---   ]]
---
---@param bindings Binding[]: the bindings for which to construct a menu
---@param numcols integer: the number of columns the help string should have
---@param name string|nil: optional; the name of the binding group; used as a title if
--- present
---@return string: a help string formatted from a list of key bindings
function MenuFormatter.format(bindings, numcols, name)
  return Menu.new(bindings, numcols, name):format()
end

---@alias HintMenuFormatter fun(b: Binding[], name: string|nil): string
---@alias HydraHint { fmttr: HintMenuFormatter, position: string, border: string, type: string }

--- Utility for formatting hydra hints. See :h hydra-config.hint.
---
---@class HintFormatter
---@field [any] any
local HintFormatter = {}
HintFormatter.__index = HintFormatter

--- Constructor
---
---@return HintFormatter: a new instance
function HintFormatter.new()
  return setmetatable({}, HintFormatter)
end


local function make_fmt(columns)
  return function(bindings, name)
    return MenuFormatter.format(bindings, columns, name)
  end
end


local function parse_name(k)
  local parts = String.split(k, '_')

  if #parts < 2 then
    Err.raise('Hydra.HintFormatter: function name should consist of 2/3 tokens separated by "_" (%s)', k)
  end

  if not Num.isstrint(Array.index(parts, -1))  then
    Err.raise('Hydra.HintFormatter: the function name token after the last "_" must be an int (%s)', k)
  end

  -- get the colnums value from the name; it's the value after the last "_"
  local colnums = Num.as(Array.index(parts, -1))
  -- join the rest of the array entries by "-" to get the position
  local position = String.join(Array.slice(parts, 1, -1), '-')

  return position, colnums
end


local function make_hint_opts(position, cols)
  return function() return
    {
      border   = 'rounded',
      fmttr    = make_fmt(cols),
      position = position,
      type     = 'window',
    }
  end
end


--- Custom index metamethod that expects function name keys of the following form:
---
---   [hydra.nvim hint position]_[number of columns in hint format]
---
--- More concretely:
---
---   middle_right_1, bottom_3, middle_4
---
--- The function name is parsed and used to construct hydra hint config, as well as a menu
--- formatter used by KeyMapper to format hydra binding hints.
---
---@param k string: a function name in the aforementioned format
---@return fun(): HydraHint a function that returns config for a hydra hint menu; all but
--- fmttr is native to hydra (see :h hydra-config.hint)
function HintFormatter:__index(k)
  local pos, cols = parse_name(k)
  return make_hint_opts(pos, cols)
end

return {
  Constants     = Constants,
  HintFormatter = HintFormatter.new(),
}


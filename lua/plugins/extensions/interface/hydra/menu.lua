local Num  = require 'toolbox.core.num'
local Iter = require 'toolbox.utils.iter'

local map = require('toolbox.utils.map').map


--- Container for constants.
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

return {
  Constants     = Constants,
  MenuFormatter = MenuFormatter,
}


local enum = require('toolbox.extensions.enum').enum

--- Represents different "locations" to which text can be copied.
---
---@enum Register
local Register = {
  UNNAMED = '*',
  UNNAMED_PLUS = '+',
}

--- Represents the various vim modes.
---
---@enum Mode
local Mode = enum({
  COMMAND = 'c',
  INSERT = 'i',
  NORMAL = 'n',
  SELECT = 's',
  TERMINAL = 't',
  VISUAL = 'v',
  X = 'x',
})

--- Nearly non-existent wrapper around nvim functions related to editor interactions.

---@class Editor
local Editor = {}

---@note: so Register is publicly accessible
Editor.Register = Register
---@note: so Mode is publicly accessible
Editor.Mode = Mode

---@see vim.api.nvim_get_mode
---
---@return Mode: the editor's current mode
---@error if mode can't be determined
function Editor.mode()
  local mode = vim.api.nvim_get_mode().mode

  if mode == nil then
    Err.raise 'Editor.mode: unable to find editor mode'
  end

  return Mode[mode]
end

--- Checks if the editor's current mode == the provided mode.
---
---@param mode Mode: the mode to check
---@return boolean: true if the editor's current mode == mode, false otherwise
function Editor.is_mode(mode)
  return mode == Mode[Editor.mode()]
end

---@see vim.fn.getcmdline
function Editor.cmdline()
  return vim.fn.getcmdline()
end

--- Copies text to the provided register, or to the system register if none is provided.
---
---@param text string: the text to copy
---@param register Register|nil: optional, defaults to "UNNAMED_PLUS"; the location to
--- which to copy text; determines where the text can be pasted
function Editor.copy(text, register)
  register = register or Register.UNNAMED_PLUS
  vim.fn.setreg(register, text)
end

return Editor

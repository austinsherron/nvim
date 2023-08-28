
--- Represents different "locations" to which text can be copied.
---
---@enum Register
local Register = {
  SYSTEM = '*',
}

--- Nearly non-existent wrapper around nvim functions related to editor interactions.

---@class Editor
local Editor = {}

---@see vim.fn.getcmdline
function Editor.cmdline()
  return vim.fn.getcmdline()
end


--- Copies text to the provided register, or to the system register if none is provided.
---
---@param text string: the text to copy
---@param register Register|nil: the location to which to copy text; determines where the
--- text can be pasted
function Editor.copy(text, register)
  vim.fn.setreg(register, text)
end

return Editor


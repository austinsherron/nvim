--- Contains functions for configuring the outline plugin.
---
---@class Outline
local Outline = {}

---@return table: a table that contains configuration values for the outline plugin
function Outline.opts()
  return {
    outline_window = {
      position = 'right',
    },
    symbol_folding = {
      autofold_depth = 1,
    },
    keymaps = {
      close = { '<Esc>', 'q', '<leader>q' },
    },
  }
end

return Outline

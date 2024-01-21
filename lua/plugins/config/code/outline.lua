--- Contains functions for configuring the symbols-outline plugin.
---
---@class SymbolsOutline
local SymbolsOutline = {}

---@return table: a table that contains configuration values for the symbols-outline
--- plugin
function SymbolsOutline.opts()
  return {
    autofold_depth = 1,
    position = 'right',
    keymaps = {
      close = { '<leader>q' },
    },
  }
end

return SymbolsOutline

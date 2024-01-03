
--- Contains functions for configuring the symbols-outline plugin.
---
---@class SymbolsOutline
local SymbolsOutline = {}

---@return table: a table that contains configuration values for the symbols-outline
--- plugin
function SymbolsOutline.opts()
  return {
    autofold_depth = 0,
    position       = 'right',
    keymaps        = {
      hover_symbol = 'h',
      fold         = 'zo',
      unfold       = 'zc',
      fold_all     = 'zO',
      unfold_all   = 'zC',
    },
  }
end

return SymbolsOutline


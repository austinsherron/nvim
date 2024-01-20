--- Contains functions for configuring the neodev plugin.
---
---@class Neodev
local Neodev = {}

---@return table: a table that contains configuration values for the symbols-outline
function Neodev.opts()
  return {
    library = {
      plugins = {
        'LuaSnip',
        'lspconfig',
        'lspsaga.nvim',
        'mason.nvim',
        'scope.nvim',
        'telescope.nvim',
      },
    },
  }
end

return Neodev

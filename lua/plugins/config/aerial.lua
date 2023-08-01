
--- Contains functions for configuring aerial.
---
---@class Aerial
local Aerial = {}

---@return table: a table that contains configuration values for the aerial plugin
function Aerial.opts()
  return {
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    layout   = {
      min_width         = 40,
      default_direction = 'prefer_left',
    },
  }
end

return Aerial



--- Contains functions for configuring the treesj plugin.
---
---@class TreeSJ
local TreeSJ = {}

---@return table: a table that contains configuration values for the treesj plugin
function TreeSJ.opts()
  return {
    use_default_keymaps = false,
  }
end

return TreeSJ


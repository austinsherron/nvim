local Lsp = require 'lsp'


--- Contains functions for configuring the mason plugin.
---
---@class Mason
local Mason = {}

---@return table: a table that contains configuration values for the mason plugin
function Mason.opts()
  return {
    ensure_installed = Lsp.servers()
  }
end

return Mason


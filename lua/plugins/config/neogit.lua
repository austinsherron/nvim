
--- Contains functions for configuring the neogit plugin.
--
---@class Neogit
local Neogit = {}

---@return table: a table that contains configuration values for the neogit plugin
function Neogit.opts()
  return {
    integrations = {
      -- enable integration w/ diffview plugin
      diffview = true,
    },
  }
end

return Neogit


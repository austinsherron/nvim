local Env = require 'toolbox.system.env'


--- Contains functions for configuring the project plugin.
---
---@class Project
local Project = {}

---@return table: a table that contains configuration values for the project plugin
function Project.opts()
  return {
    detection_methods = { 'pattern' },
    exclude_dirs = {
      Env.nvundle() .. '/*',          -- exclude plugins
      Env.external_pkgs() .. '/*',    -- exclude external repos
      Env.nvim_root_pub(),            -- exclude "deployed" nvim
      Env.editors_root() .. '/nvim',  -- exclude nvim submodule
    },
  }
end

return Project


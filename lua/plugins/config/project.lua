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
      -- exclude plugins
      Env.nvundle() .. '/*'
    },
  }
end

return Project


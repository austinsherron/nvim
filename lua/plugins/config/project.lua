local env = require 'lib.lua.system.env'


local Proj = {}

function Proj.opts()
  return {
    detection_methods = { 'pattern' },
    exclude_dirs = {
      -- exclude plugins
      env.nvundle() .. '/*'
    },
  }
end

return Proj


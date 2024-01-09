--- Contains functions for configuring the autopairs plugin.
---
---@class Autopairs
local Autopairs = {}

local function opts()
  return {
    check_ts = true,
  }
end

--- Configures the autopairs plugin.
function Autopairs.config()
  local ap = require 'nvim-autopairs'

  ap.setup(opts())
  ap.add_rules(require 'nvim-autopairs.rules.endwise-lua')
end

return Autopairs

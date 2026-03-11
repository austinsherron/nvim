local Path = require 'toolbox.system.path'

--- Contains utilities for configuring the nvim-dbee plugin.
---
---@class Dbee
local Dbee = {}

--- Returns opts for the nvim-dbee plugin.
---
---@return table: opts table for the nvim-dbee plugin
function Dbee.opts()
  local FileSource = require('dbee.sources').FileSource

  return {
    sources = { FileSource:new(Path.config('dbee', 'conn.json')) },
  }
end

return Dbee

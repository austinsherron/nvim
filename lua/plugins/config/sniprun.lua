
--- Contains functions for configuring the sniprun plugin.
--
---@class SnipRun
local SnipRun = {}

---@return table: a table that contains configuration values for the sniprun plugin
function SnipRun.opts()
  return {
    display = {
      'Classic',
      'VirtualTextOk',
      'NvimNotify',
    },
  }
end

return SnipRun


--- Contains functions for configuring diffview.
---
---@class Diffview
local Diffview = {}

---@return table: a table that contains configuration values for the diffview plugin
function Diffview.opts()
  return {
    enhanced_diff_hl = true,
    view = {
      layout = 'diff2_horizontal',
    },
  }
end

return Diffview

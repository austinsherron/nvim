local enum = require('toolbox.extensions.enum').enum

--- Convenience enum mapping colors to hex codes.
---
---@enum Colors
local Colors = enum({
  RED = '#E06C75',
  ORANGE = '#D19A66',
  YELLOW = '#E5C07B',
  GREEN = '#98C379',
  BLUE = '#61AFEF',
  CYAN = '#56B6C2',
  VIOLET = '#C678DD',
})

return Colors

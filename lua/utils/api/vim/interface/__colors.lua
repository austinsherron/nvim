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
  PURPLE = '#9D79D6',

  LIGHT_ORANGE = '#F6B079',
  LIGHT_CYAN = '#40ffff',

  -- NOTE: these colors are copied from the srcery colorscheme's highlight groups
  -- TODO: figure out why linking to these highlight groups doesn't seem to work
  SRCERY_RED = '#ef2f27',
  SRCERY_ORANGE = '#ff5f00',
  SRCERY_YELLOW = '#fbb829',
  SRCERY_GREEN = '#519f50',
  SRCERY_BLUE = '#2c79bf',
  SRCERY_CYAN = '#0aaeb3',
  SRCERY_MAGENTA = '#e02c6d',

  SRCERY_BRIGHT_YELLOW = '#fed06e',
  SRCERY_BRIGHT_MAGENTA = '#ff5c8f',
})

return Colors

local enum = require('toolbox.extensions.enum').enum

--- Convenience enum mapping colors to hex codes.
---
---@enum Colors
local Colors = enum({
  -- INFO: basic colors
  RED = '#E06C75',
  ORANGE = '#D19A66',
  YELLOW = '#E5C07B',
  GREEN = '#98C379',
  BLUE = '#61AFEF',
  CYAN = '#56B6C2',
  VIOLET = '#C678DD',
  PURPLE = '#9D79D6',

  -- INFO: light variants
  LIGHT_ORANGE = '#F6B079',
  LIGHT_CYAN = '#40ffff',

  -- INFO: blacks, whites, grays
  BLUE_GREY = '#717CB4',
  LIGHT_GREY = '#D8D8D8',

  -- INFO: special colors
  MATERIAL_RED = '#F07178',
  MAUVE = '#E0B0FF',
  MEDIUM_ORCHID = '#BA55D3',
  PALE_BLUE = '#54637D',
  RED_ORANGE = '#F78C6C',
  SAFETY_BLUE = '#2E4F85',
  SEA_GREEN = '#9abcb6',

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

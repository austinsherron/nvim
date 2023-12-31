local Lazy = require 'toolbox.utils.lazy'

local telescope = Lazy.require('telescope')


local DEFAULTS = {
  layout_strategy = 'vertical',
}

-- TODO: configure these individually based on usability
local PICKERS = {
  buffers       = { theme = 'ivy'      },
  spell_suggest = { theme = 'cursor'   },
}

-- TODO: configure these individually based on their setup params
local EXTENSIONS = {
  aerial    = {},
  emoji     = {},
  frecency  = {},
  notify    = {},
  persisted = {},
  projects  = {},
  scope     = {},
  undo      = {},
}

local OPTS = {
  defaults   = DEFAULTS,
  pickers    = PICKERS,
  extensions = EXTENSIONS,
}

--- Contains functions for configuring the telescope plugin and its extensions.
---
---@class Telescope
local Telescope = {}

--- Configures the telescope plugin.
function Telescope.config()
  ---@diagnostic disable-next-line: undefined-field
  telescope.setup(OPTS)

  for name, _ in pairs(EXTENSIONS) do
    ---@diagnostic disable-next-line: undefined-field
    telescope.load_extension(name)
  end
end

return Telescope


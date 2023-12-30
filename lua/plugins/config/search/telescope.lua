local Lazy = require 'toolbox.utils.lazy'

local telescope = Lazy.require('telescope')


local PICKERS = {
  buffers = {
    theme = 'ivy',
  },
  spell_suggest = {
    theme = 'cursor',
  },
}

local EXTENSIONS = {
  -- FIXME: can't actually figure how how to make config here work
  aerial    = {},
  emoji     = {},
  frecency  = {},
  notify    = {},
  persisted = {},
  projects  = {},
  scope     = {},
  undo      = {
    -- side_by_side    = true,
    -- layout_strategy = 'vertical',
    -- layout_config   = {
    --   preview_height = 0.3,
    -- },
  },
}

local OPTS = {
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


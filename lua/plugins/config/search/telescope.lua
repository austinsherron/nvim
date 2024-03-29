local telescope = Lazy.require 'telescope'

local DEFAULTS = {
  layout_strategy = 'vertical',
}

-- TODO: configure these individually based on usability
local PICKERS = {
  buffers = { theme = 'ivy' },
  colorscheme = { theme = 'ivy' },
  diagnostics = { layout_strategy = 'horizontal' },
  git_bcommits = { layout_strategy = 'horizontal' },
  git_stash = { layout_strategy = 'horizontal' },
  help_tags = { layout_strategy = 'horizontal' },
  man_pages = { theme = 'ivy' },
  -- TODO: see if I can make the dropdown lower, or put the viewer below the prompt
  treesitter = { theme = 'dropdown' },
  spell_suggest = { theme = 'cursor' },
}

-- TODO: configure these individually based on their setup params
local EXTENSIONS = {
  emoji = {},
  frecency = { default_workspace = 'CWD' },
  notify = {},
  persisted = {},
  projects = {},
  scope = {},
  undo = {},
  yaml_schema = {},
  zoxide = {},
}

local OPTS = {
  defaults = DEFAULTS,
  pickers = PICKERS,
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

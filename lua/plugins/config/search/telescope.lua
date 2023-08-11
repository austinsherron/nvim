
local TELESCOPE_EXTENSIONS = { 'aerial', 'emoji', 'frecency', 'projects', 'undo' }

local function load_telescope_ext(name)
  require('telescope').load_extension(name)
end


local function opts()
  return {
    extensions = {
      undo = {
        side_by_side = true,
        layout_strategy = 'vertical',
        layout_config = {
          preview_height = 0.8,
        }
      }
    }
  }
end

--- Contains functions for configuring the telescope plugin and its extensions.
---
---@class Telescope
local Telescope = {}

--- Configures the telescope plugin.
function Telescope.config()
  require('telescope').setup(opts())

  for _, tsc_ext in ipairs(TELESCOPE_EXTENSIONS) do
    load_telescope_ext(tsc_ext)
  end
end

return Telescope


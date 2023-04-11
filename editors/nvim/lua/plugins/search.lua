-- search ----------------------------------------------------------------------

--[[
  make it easier to find things
--]]

local km = require('nvim.lua.utils.mapper')
require 'nvim.lua.plugins.config.telescope'


local TELESCOPE_EXTENSIONS = { 'emoji', 'frecency', 'projects', 'undo' }

local function load_telescope_ext(name)
  require('telescope').load_extension(name)
end


function telescope_config(_, opts)
  require('telescope').setup(opts)

  for _, tsc_ext in ipairs(TELESCOPE_EXTENSIONS) do
    load_telescope_ext(tsc_ext)
  end
end


return {
---- telescope: fuzzy pop-out search
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.1',
    dependencies = { 
      'nvim-lua/plenary.nvim' ,
      'debugloop/telescope-undo.nvim',
    },
    opts = telescope_opts(),
    config = telescope_config,
  },
---- telescope-emoji: telescearch for emojis!
  { 'xiyaowong/telescope-emoji.nvim' },
---- telescope-"f"recency: telescearch frequently~recently used files 
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
  }
}


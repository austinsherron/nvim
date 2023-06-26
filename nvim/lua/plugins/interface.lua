-- interface -------------------------------------------------------------------

--[[
  add, control, or augment interface elements; interface elements should do
  something, or at least be informational
--]]

require 'nvim.lua.plugins.config.alphanvim'


return {
---- alpha: landing page
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- opts = {}, -- alphanvim_opts(),

    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },
---- barbar: buffer bar
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '^1.0.0',     -- optional: only update when a new 1.x version is released
  },
---- TODO: cmp-cmdline: fuzzy completion of commands
  { 
    'hrsh7th/cmp-cmdline',
    enabled = false,
  },
---- TODO: customize: lualine: status line
  {
    'nvim-lualine/lualine.nvim',

    config = function()
      require('lualine').setup()
    end
  },
---- undotree: visualize a file/buffer's change history
  {'mbbill/undotree'},
}


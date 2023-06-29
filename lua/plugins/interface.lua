-- interface -------------------------------------------------------------------

--[[
  add to, control, or augment interface elements; interface elements should do
  something, or at least be informational
--]]

-- local alpha = require 'nvim.lua.plugins.config.alphanvim'
local bb = require 'nvim.lua.plugins.config.barbar'


return {
---- alpha: landing page
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- opts = {}, -- alpha.opts(),

    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },
---- barbar: buffer bar
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = bb.opts(),
  },
---- bufferline: another buffer bar; note: disabled since barbar does what I want
----             it to for now
  {
    'akinsho/bufferline.nvim',
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = "*",

    config = function()
      require("bufferline").setup({})
    end
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
---- which-key: visualize keybindings based on what's typed
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',

    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 700
    end,
  }
}


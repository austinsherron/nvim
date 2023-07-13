-- interface -------------------------------------------------------------------

--[[
  add to, control, or augment interface elements; interface elements should do
  something, or at least be informational
--]]

-- local alpha = require 'nvim.lua.plugins.config.alphanvim'
local bb = require 'nvim.lua.plugins.config.barbar'
local ll = require 'nvim.lua.plugins.config.lualine'
local plugins = require('nvim.lua.utils.plugin').plugins


return plugins({
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
  ---- bqf (better quickfix window): makes quickfix window more user-friendly
  {
    'kevinhwang91/nvim-bqf',
    dependencies = { 'junegunn/fzf.vim' },
  },
  ---- bufferline: another buffer bar; note: disabled since barbar does what I want
  ----             it to for now
  ({
    'akinsho/bufferline.nvim',
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',

    config = function()
      require('bufferline').setup({})
    end
  }),
  ---- fzf: fuzzy-finder
  {
    'junegunn/fzf',

    build = function()
      vim.fn['fzf#install']()
    end
  },
  ---- fzf.vim: collection of fzf vim integrations/utilities
  { 'junegunn/fzf.vim' },
  ---- lualine: status line; TODO: customize
  {
    'nvim-lualine/lualine.nvim',
    opts = ll.opts(),

    config = function(_, opts)
      require('lualine').setup(opts)
    end
  },
  ---- notify: pretty notifications
  {
    'rcarriga/nvim-notify',

    -- substitute all native vim notifications
    config = function()
      vim.notify = require('notify')
    end
  },
  ---- undotree: visualize a file/buffer's change history
  { 'mbbill/undotree' },
  ---- which-key: visualize keybindings based on what's typed
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',

    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 700
    end,

    config = function(_, opts)
      require('which-key').setup(opts)
    end
  },
})


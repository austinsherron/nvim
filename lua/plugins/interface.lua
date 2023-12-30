
-- interface -------------------------------------------------------------------

--[[
  add to, control, and/or augment interface elements; interface elements should
  do something, or at least be informational
--]]

-- local alpha = require 'plugins.config.interface.alphanvim'
local Barbar    = require 'plugins.config.interface.barbar'
local Lightbulb = require 'plugins.config.interface.lightbulb'
local Lualine   = require 'plugins.config.interface.lualine'
local Sidebar   = require 'plugins.config.interface.sidebar'
local Trouble   = require 'plugins.config.interface.trouble'
local Priority  = require 'utils.plugins.priority'

local Plugins = require('utils.plugins.plugin').plugins


return Plugins({
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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts         = Barbar.opts(),
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
    enabled      = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version      = '*',

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
  ---- hydra: custom shortcut repetitions, sub-modes, and sub-menus
  ---- TODO: continue to convert specific key binding groups to hydra menus (i.e.: git,
  ----       lsp, misc tools, etc.)
  { 'anuvyklack/hydra.nvim' },
  ---- lightbulb: ide style 💡 to mark code actions
  {
    'kosayoda/nvim-lightbulb',
    opts = Lightbulb.opts(),

    config = function(_, opts)
      require('nvim-lightbulb').setup(opts)
    end
  },
  ---- lualine: status line; TODO: customize
  {
    'nvim-lualine/lualine.nvim',
    opts = Lualine.opts(),

    config = function(_, opts)
      require('lualine').setup(opts)
    end
  },
  ---- notify: pretty notifications
  {
    'rcarriga/nvim-notify',
    lazy         = false,
    dependencies = { 'MunifTanjim/nui.nvim' },

    -- we load this second since we want nvim-notify as early as possible; this comes after
    -- nui.nvim since that is a dependency of this
    priority = Priority.SECOND,

    -- substitute all native vim notifications
    config = function()
      vim.notify = require('notify')
    end
  },
  ---- sidebar: module sidebar (TODO: configure further)
  {
    'sidebar-nvim/sidebar.nvim',
    opts = Sidebar.opts(),

    config = function(_, opts)
      require('sidebar-nvim').setup(opts)
    end
  },
  ---- trouble.nvim: fancy list for diagnostics, etc.
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts         = Trouble.opts(),

    config = function(_, opts)
      require('trouble').setup(opts)
    end,
  },
  ---- todo-comments: highlight, list, search "TODO", "FIXME", etc. type comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function(_, opts)
      require('todo-comments').setup(opts)
    end,
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


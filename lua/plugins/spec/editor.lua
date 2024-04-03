-- editor ----------------------------------------------------------------------

--[[
  control core editor capabilities like commenting, completion, general text
  manipulation, etc.
--]]

local AutoPairs = require 'plugins.config.editor.autopairs'
local Boole = require 'plugins.config.editor.boole'
local Cmp = require 'plugins.config.editor.cmp.cmp'
local Indent = require 'plugins.config.interface.indent'
local Treesitter = require 'plugins.config.code.treesitter'

local Plugins = require('utils.plugins.plugin').plugins

local TsPlugin = Treesitter.TreesitterPlugin

return Plugins('editor', {
  ---- auto-pairs: automatic insertion of closing "x", where = ", ', ), }, etc.
  {
    'windwp/nvim-autopairs',
    enabled = Treesitter.enabled(TsPlugin.AUTOPAIRS),
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = AutoPairs.config,
  },
  ---- boole: smarter toggling, toggle-loops, etc.
  {
    'nat-418/boole.nvim',
    opts = Boole.opts(),

    config = function(_, opts)
      require('boole').setup(opts)
    end,
  },
  ---- cmp: completion engine
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = Cmp.config,
  },
  ---- cmp-buffer: fuzzy completion of buffer contents
  {
    'hrsh7th/cmp-buffer',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-calc: fuzzy completion of math calculation
  {
    'hrsh7th/cmp-calc',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-cmdline: fuzzy completion of commands
  {
    'hrsh7th/cmp-cmdline',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  -- cmp-"conventional commits": auto-completion for conventional git commit message terms
  {
    'davidsierradz/cmp-conventionalcommits',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-dictionary: fuzzy completion of words in dictionary
  {
    'uga-rosa/cmp-dictionary',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-emoji: fuzzy completion of emojis
  {
    'hrsh7th/cmp-emoji',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-git: fuzzy completions from git + github + gitlab
  {
    'petertriho/cmp-git',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-lsp: fuzzy completion based on available lsp servers
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-lsp-signature-help: displays function signature hover-help during relevant
  ---- completion events
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-luasnip: completion for LuaSnip snippets
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-nvim-lua: completion n/vim lua api
  {
    'hrsh7th/cmp-nvim-lua',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-path: fuzzy completion of file system paths
  {
    'hrsh7th/cmp-path',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-spell: fuzzy completion of spelling suggestions
  {
    'f3fora/cmp-spell',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- cmp-treesitter: fuzzy completion of treesitter nodes
  {
    'ray-x/cmp-treesitter',
    enabled = Treesitter.enabled(TsPlugin.CMP_TREESITTER),
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  ---- comment: manipulate code comments easily
  {
    'numToStr/Comment.nvim',

    config = function()
      require('Comment').setup()
    end,
  },
  ---- editor config: language specific file formatting
  { 'gpanders/editorconfig.nvim' },
  ---- indent-blankline: indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = Treesitter.enabled(TsPlugin.INDENT_BLANKLINE),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    config = Indent.config,
  },
  ---- rainbow delimiters: make delimiter pairs more obvious using the power of the
  ---- rainbow! 🌈
  {
    'HiPhish/nvim-ts-rainbow2',
    enabled = Treesitter.enabled(TsPlugin.TS_RAINBOW),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  ---- surround: efficient manipulation of brackets, quotes, etc.
  {
    'kylechui/nvim-surround',
    enabled = Treesitter.enabled(TsPlugin.SURROUND),
    version = '*', -- use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    config = function()
      require('nvim-surround').setup()
    end,
  },
  ---- treesitter-endwise: automatically close various semantic structures, i.e.:
  ---- if-then-end, etc.
  ---- TODO: doesn't work at the moment (08/25/2023, after "fixing" treesitter highlight
  ---- issue)
  {
    'RRethy/nvim-treesitter-endwise',
    enabled = Treesitter.enabled(TsPlugin.ENDWISE),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
  },
  ---- treesitter-playground: view treesitter functional info in nvim
  {
    'nvim-treesitter/playground',
    enabled = Treesitter.enabled(TsPlugin.PLAYGROUND),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
})

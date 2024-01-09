local KeyMapper = require 'utils.core.mapper'
local Window = require 'utils.api.vim.window'

local HintFmttr = require('plugins.extensions.interface.hydra').HintFormatter

local Dir = Window.WindowOpDirection

local KM = KeyMapper.new({ desc_prefix = 'smart-splits: ', nowait = true })

-- interactions ----------------------------------------------------------------

-- FIXME: arrow-key bindings for "moving buffers" don't work consistently
KM:with_hydra({ name = '⬅⬆⬇➡ Resize', body = '<leader>R' })
  :with({ hint = HintFmttr.bottom_3() })
  :bind({
    -- order is for column formatting: each group of three is a row
    {
      'j',
      function()
        Window.resize(Dir.DOWN)
      end,
      { desc = 'resize down' },
    },
    {
      'J',
      function()
        Window.swap(Dir.DOWN)
      end,
      { desc = 'swap buffer down' },
    },
    { '<Down>', '<C-w>J', { desc = 'move buffer down' } },
    {
      'k',
      function()
        Window.resize(Dir.UP)
      end,
      { desc = 'resize up' },
    },
    {
      'K',
      function()
        Window.swap(Dir.UP)
      end,
      { desc = 'swap buffer up' },
    },
    { '<Up>', '<C-w>J', { desc = 'move buffer up' } },
    {
      'h',
      function()
        Window.resize(Dir.LEFT)
      end,
      { desc = 'resize left' },
    },
    {
      'H',
      function()
        Window.swap(Dir.LEFT)
      end,
      { desc = 'swap buffer left' },
    },
    { '<Left>', '<C-w>H', { desc = 'move buffer left' } },
    {
      'l',
      function()
        Window.resize(Dir.RIGHT)
      end,
      { desc = 'resize right' },
    },
    {
      'L',
      function()
        Window.swap(Dir.RIGHT)
      end,
      { desc = 'swap buffer right' },
    },
    { '<Right>', '<C-w>H', { desc = 'move buffer right' } },
  })
  :done({ purge = 'current' })

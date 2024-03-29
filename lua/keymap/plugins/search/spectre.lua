local Editor = require 'utils.api.vim.editor'
local KeyMapper = require 'utils.core.mapper'

local spectre = Lazy.require 'spectre' ---@module 'spectre'

local KM = KeyMapper.new({
  desc_prefix = 'spectre: ',
  nowait = true,
})

-- interactions ----------------------------------------------------------------

local function spectre_cmd(cmd, select_word)
  return function()
    spectre[cmd]({ select_word = select_word })
  end
end

local function make_open(cmd, view_mode, select_word)
  cmd = cmd or Editor.window_aware_split('split').new
  view_mode = view_mode or cmd

  return function()
    --- NOTE: admittedly a hack to change opening position
    spectre.setup({ open_cmd = view_mode })
    spectre_cmd(cmd, select_word)()
  end
end

-- TODO: consider a more complete remapping of available actions:
--       https://github.com/nvim-pack/nvim-spectre
KM:bind({
  { '<leader>so', make_open(), { desc = 'open' } },
  { '<leader>sv', make_open('vnew', 'vsplit'), { desc = 'open in vsplit' } },
  { '<leader>sh', make_open('new', 'split'), { desc = 'open in split' } },
  {
    '<leader>sw',
    make_open('open_visual', nil, true),
    { desc = 'search current word' },
  },
  {
    '<leader>sw',
    make_open('open_visual', nil, true),
    { desc = 'search current word' },
    { 'v' },
  },
  {
    '<leader>sp',
    make_open('open_file_search', nil, true),
    { desc = 'search on current file' },
  },
  { '<leader>sx', spectre_cmd 'close', { desc = 'close' } },
})

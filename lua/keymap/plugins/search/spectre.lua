local Editor = require 'utils.api.vim.editor'
local KeyMapper = require 'utils.core.mapper'
local Type = require 'toolbox.meta.type'

local ViewMode = require('utils.api.vim.buffer').ViewMode

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

local function open(cmd, select_word)
  local view_mode

  if String.is(cmd) or cmd == nil then
    view_mode = Editor.window_aware_split()
  elseif Type.is(cmd, ViewMode) then
    view_mode = cmd.new
    cmd = view_mode
  else
    Err.raise('unrecognized spectre cmd: %s', cmd)
  end

  return function()
    --- NOTE: admittedly a hack to change opening position
    spectre.setup({ open_cmd = view_mode })
    spectre_cmd(cmd, select_word)()
  end
end

-- TODO: consider a more complete remapping of available actions:
--       https://github.com/nvim-pack/nvim-spectre
KM:bind({
  { '<leader>so', open(), { desc = 'open' } },
  { '<leader>sv', open(ViewMode.VSPLIT), { desc = 'open in vsplit' } },
  { '<leader>sh', open(ViewMode.SPLIT), { desc = 'open in split' } },
  { '<leader>sw', open('open_visual', true), { desc = 'search word' } },
  { '<leader>sw', open('open_visual', true), { desc = 'search current word' }, { 'v' } },
  { '<leader>sp', open('open_file_search', true), { desc = 'search on current file' } },
  { '<leader>sx', spectre_cmd 'close', { desc = 'close' } },
})

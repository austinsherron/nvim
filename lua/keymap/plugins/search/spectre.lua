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

local function makeopen(open_cmd)
  return function()
    local open = spectre_cmd 'open'

    --- NOTE: admittedly a hack to change opening position
    spectre.setup({ open_cmd = open_cmd })
    open()
  end
end

-- TODO: consider a more complete remapping of available actions:
--       https://github.com/nvim-pack/nvim-spectre
KM:bind({
  { '<leader>so', makeopen 'vnew', { desc = 'open' } },
  { '<leader>sv', makeopen 'vnew', { desc = 'open in vsplit' } },
  { '<leader>sh', makeopen 'new', { desc = 'open in split' } },
  { '<leader>sx', spectre_cmd 'close', { desc = 'close' } },
  { '<leader>sw', spectre_cmd('open_visual', true), { desc = 'search current word' } },
  { '<leader>sw', spectre_cmd('open_visual', true), { desc = 'search current word' }, { 'v' } },
  { '<leader>sp', spectre_cmd('open_file_search', true), { desc = 'search on current file' } },
})

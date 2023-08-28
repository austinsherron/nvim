local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({
  desc_prefix = 'spectre: ',
  nowait      = true,
  silent      = true,
})

local function spectre_cmd(cmd, select_word)
  return function()
    require('spectre')[cmd]({ select_word = select_word })
  end
end

-- interactions ----------------------------------------------------------------

-- TODO: consider a more complete remapping of available actions:
--       https://github.com/nvim-pack/nvim-spectre
KM:bind({
  { '<leader>S',  spectre_cmd('open',             false), { desc = 'open'                   }},
  { '<leader>sx', spectre_cmd('close',            false), { desc = 'close'                  }},
  { '<leader>sw', spectre_cmd('open_visual',      true),  { desc = 'search current word'    }},
  { '<leader>sw', spectre_cmd('open_visual',      false), { desc = 'search current word'    }, { 'v' }},
  { '<leader>sp', spectre_cmd('open_file_search', true),  { desc = 'search on current file' }},
})


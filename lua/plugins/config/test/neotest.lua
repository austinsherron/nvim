
--- Contains functions for configuring the neotest plugin.
---
---@class Neotest
local Neotest = {}

local function python_adapter()
  return require('neotest-python')({
    runner = 'unittest',
  })
end


local function vim_test_adapter()
  return require('neotest-vim-test')({
    ignore_file_types = { 'python' },
  })
end


--- Configures the neotest plugin.
function Neotest.config()
  require('neotest').setup({
    adapters = {
      python_adapter(),
      vim_test_adapter(),
    },
  })
end

return Neotest


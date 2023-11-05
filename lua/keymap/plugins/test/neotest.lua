local Test      = require 'utils.api.test'
local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- neotest ---------------------------------------------------------------------

KM:with({ desc_prefix = 'neotest (view): ' })
  :bind({
    { '<leader>To', Test.open_output,      { desc = 'open output'    }},
    { '<leader>Ts', Test.display_summary,  { desc = 'toggle summary' }},
}):done()


KM:with({ desc_prefix = 'neotest (run): ' })
  :bind({
    { '<leader>Tf', Test.run_current_file, { desc = 'run test(s) in current file' }},
    { '<leader>Tl', Test.run_last,         { desc = 'run last test(s)'            }},
    { '<leader>Tn', Test.run_nearest,      { desc = 'run nearest test(s)'         }},
}):done()


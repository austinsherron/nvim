local Test      = require 'utils.api.test'
local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- interactions ----------------------------------------------------------------

KM:with({ desc_prefix = 'neotest: ' })
  :bind({
    { '[t', Test.prev_failed, { desc = 'Previous failed test' }},
    { ']t', Test.next_failed, { desc = 'Next failed test'     }},
}):done()

KM:with({ desc_prefix = 'neotest (view): ' })
  :bind({
    { "'to", Test.open_output,      { desc = 'open output'    }},
    { "'ts", Test.display_summary,  { desc = 'toggle summary' }},
}):done()

KM:with({ desc_prefix = 'neotest (run): ' })
  :bind({
    { "'tf", Test.run_current_file,  { desc = 'run test(s) in current file' }},
    { "'tl", Test.run_last,          { desc = 'run last test(s)'            }},
    { "'tn", Test.run_nearest,       { desc = 'run nearest test(s)'         }},
}):done()


local neotest = require 'neotest'

--- Api wrapper around unit test runner plugin.
---
---@class Test
local Test = {}

--- Runs the "nearest" (to cursor) unit test(s).
function Test.run_nearest()
  neotest.run.run()
end

--- Runs the last unit test(s).
function Test.run_last()
  neotest.run.run_last()
end

--- Runs the unit test(s) in the current file.
function Test.run_current_file()
  neotest.run.run(vim.fn.expand '%')
end

--- Opens the output of test results.
function Test.open_output()
  ---@diagnostic disable-next-line: missing-fields
  neotest.output.open({ enter = true })
end

--- Navigates to the "previous" (above the cursor) failed test.
function Test.prev_failed()
  neotest.jump.prev({ status = 'failed' })
end

--- Navigates to the "next" (below the cursor) failed test.
function Test.next_failed()
  neotest.jump.next({ status = 'failed' })
end

--- Toggles a window w/ info about and results of the current test suite. Additionally
--- enables interacting (i.e.: running) w/ that test suite.
function Test.display_summary()
  neotest.summary.toggle()
end

return Test

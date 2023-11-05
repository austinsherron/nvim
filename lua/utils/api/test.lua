local neotest = require 'neotest'


--- Contains utilities for running unit tests.
---
---@class Test
local Test = {}

--- Runs the "nearest" unit test(s).
function Test.run_nearest()
  neotest.run.run()
end


--- Runs the last unit test(s).
function Test.run_last()
  neotest.run.run_last()
end


--- Runs the unit test(s) in the current file.
function Test.run_current_file()
  neotest.run.run(vim.fn.expand("%"))
end


--- Opens the output of test results.
function Test.open_output()
---@diagnostic disable-next-line: missing-fields
  neotest.output.open({ enter = true })
end


--- Displays the info about and results of the current test suite. Additionally enables
--- interactions (i.e.: running) w/ that test suit.
function Test.display_summary()
  neotest.summary.open()
end

return Test


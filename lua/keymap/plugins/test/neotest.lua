local Hydra = require 'plugins.extensions.interface.hydra'
local KeyMapper = require 'utils.core.mapper'
local Test = require 'utils.api.test'

local Constants = Hydra.Constants
local HintFmttr = Hydra.HintFormatter

local KM = KeyMapper.new({ nowait = true })

-- interactions ----------------------------------------------------------------

KM:with_hydra({ name = '🚨 Neotest', body = "'t" })
  :with({ hint = HintFmttr.middle_right_1(), color = 'pink' })
  :bind({
    { 'K', Test.prev_failed, { desc = 'Previous failed test' } },
    { 'J', Test.next_failed, { desc = 'Next failed test' } },
    Constants.VERTICAL_BREAK,
    { 'o', Test.open_output, { desc = 'open output' } },
    { 's', Test.display_summary, { desc = 'toggle summary' } },
    Constants.VERTICAL_BREAK,
    { 'f', Test.run_current_file, { desc = 'run test(s) in current file' } },
    { 'l', Test.run_last, { desc = 'run last test(s)' } },
    { 'n', Test.run_nearest, { desc = 'run nearest test(s)' } },
  })
  :done({ purge = 'current' })

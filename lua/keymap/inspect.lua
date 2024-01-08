local Inspect   = require 'utils.api.inspect'
local KeyMapper = require 'utils.core.mapper'

local HintFmttr = require('plugins.extensions.interface.hydra').HintFormatter


local KM = KeyMapper.new({ desc_prefix = 'inspect: ', nowait = true })

-- interactions ----------------------------------------------------------------

KM:with_hydra({ name = '🔍 Inspect', body = '<leader>I' })
  :with({ hint = HintFmttr.middle_2(), color = 'pink', esc = true })
  :bind({
    { 'd', Inspect.cwd,    { desc = 'cwd'            }},
    { 'b', Inspect.buffer, { desc = 'current buffer' }},
    { 't', Inspect.tab,    { desc = 'current tab'    }},
    { 'w', Inspect.window, { desc = 'current window' }},
  })


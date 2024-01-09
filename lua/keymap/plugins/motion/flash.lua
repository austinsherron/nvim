local Jump = require 'utils.api.jump'
local KeyMapper = require 'utils.core.mapper'

local KM = KeyMapper.new({ desc_prefix = 'flash: ', nowait = true })

-- interactions ----------------------------------------------------------------

KM:bind({
  {
    ';',
    function()
      Jump:directional(true)
    end,
    { desc = 'jump forward' },
    { 'n', 'x' },
  },
  {
    '"',
    function()
      Jump:directional(false)
    end,
    { desc = 'jump backward' },
    { 'n', 'x' },
  },
  {
    'T',
    function()
      Jump:ts_search(true)
    end,
    { desc = 'jump forward w/ treesitter' },
    { 'n', 'x', 'o' },
  },
  {
    ',',
    function()
      Jump:to_line()
    end,
    { desc = 'jump to line' },
    { 'n', 'x' },
  },
  { 'Q', Jump.treesitter, { desc = 'jump to treesitter symbol' }, { 'n', 'x', 'o' } },
  { '<M-s>', Jump.toggle, { desc = 'toggle flash search' } },
})

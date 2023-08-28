local KeyMapper = require 'utils.core.mapper'


-- interactions ----------------------------------------------------------------

local KM = KeyMapper.new({
  desc   = 'lazy: open plugin mgr.',
  nowait = true,
  silent = true,
})

KM:bind_one('<leader>Z', ':Lazy<CR>')



-- settings --------------------------------------------------------------------

--[[
  contains autocommands related to core settings
--]]

local Autocmd = require 'utils.core.autocmd'


-- so lines inserted from comments don't cause comment continuation
Autocmd.new()
  :withEvents({ 'BufNewFile', 'BufRead' })
  :withOpt('command', 'setlocal formatoptions-=cro')
  :create()


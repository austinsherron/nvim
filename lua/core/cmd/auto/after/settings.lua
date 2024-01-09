
-- settings --------------------------------------------------------------------

--[[
  contains autocommands related to core settings
--]]

local Autocmd = require 'utils.core.autocmd'


GetLogger('AUTOCMD'):info('Creating settings autocmds')

-- so lines inserted from comments don't cause comment continuation
Autocmd.new()
  :withDesc('Sets formatoptions')
  :withEvents({ 'BufNewFile', 'BufRead' })
  :withOpt('command', 'setlocal formatoptions-=cro')
  :create()


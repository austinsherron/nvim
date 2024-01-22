-- settings --------------------------------------------------------------------

--[[
  contains autocommands related to core settings
--]]

local Autocmd = require 'utils.core.autocmd'
local ColorColumn = require 'utils.core.colorcol'

GetLogger('AUTOCMD'):info 'Creating settings autocmds'

-- so lines inserted from comments don't cause comment continuation
Autocmd.new()
  :withDesc('Sets formatoptions')
  :withEvents({ 'BufNewFile', 'BufRead' })
  :withOpt('command', 'setlocal formatoptions-=cro')
  :create()

Autocmd.new()
  :withDesc('Enables language specific color column')
  :withEvent('BufEnter')
  :withCallback(Safe.ify(function(ev)
    ColorColumn.forbuf(ev.buf)
  end))
  :create()

Autocmd.new()
  :withDesc('Disables color column when leaving buffer')
  :withEvent('BufLeave')
  :withCallback(Safe.ify(ColorColumn.disable))
  :create()

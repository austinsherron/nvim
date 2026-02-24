-- settings --------------------------------------------------------------------

--[[
  contains autocommands related to core settings
--]]

local Autocmd = require 'utils.core.autocmd'
local ColorColumn = require 'utils.core.colorcol'

GetLogger('AUTOCMD'):info 'Creating settings autocmds'

Autocmd.new()
  :withDesc("Sets formatoptions so comments don't continue on new lines")
  :withEvents({ 'BufNewFile', 'BufRead' })
  :withOpt('command', 'setlocal formatoptions-=cro')
  :create()

Autocmd.new()
  :withDesc('Enables language specific color column')
  :withEvent('BufEnter')
  :withCallback(function(ev)
    ColorColumn.forbuf(ev.buf)
  end)
  :create()

Autocmd.new()
  :withDesc('Disables color column when leaving buffer')
  :withEvent('BufLeave')
  :withCallback(ColorColumn.disable)
  :create()

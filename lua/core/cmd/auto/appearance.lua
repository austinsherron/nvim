-- appearance ------------------------------------------------------------------

--[[
  contains autocommands related to ui/appearance
--]]

local Autocmd = require 'utils.core.autocmd'

local colorizer = Lazy.require 'colorizer' ---@module 'colorizer'

GetLogger('AUTOCMD'):info 'Creating appearance autocmds'

-- TODO: the colorizer autocmds aren't working

Autocmd.new()
  :withDesc('Attaches colorizer to buffer')
  :withEvent('BufEnter')
  :withCallback(function(ev)
    colorizer.attach_to_buffer(ev.buf)
  end)
  :create()

Autocmd.new()
  :withDesc('Detaches colorizer from buffer on leave')
  :withEvent('BufEnter')
  :withCallback(function(ev)
    colorizer.detach_from_buffer(ev.buf)
  end)
  :create()

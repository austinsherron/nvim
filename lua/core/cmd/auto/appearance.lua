-- appearance ------------------------------------------------------------------

--[[
  contains autocommands related to ui/appearance
--]]

local Autocmd = require 'utils.core.autocmd'
local Interface = require 'utils.api.vim.interface'

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
  :withEvent('BufLeave')
  :withCallback(function(ev)
    colorizer.detach_from_buffer(ev.buf)
  end)
  :create()

Autocmd.new()
  :withDesc('Creates custom highlights when colorscheme changes')
  :withEvent('ColorScheme')
  :withCallback(Interface.set_custom_highlights)
  :create()

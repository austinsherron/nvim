-- resize ----------------------------------------------------------------------

--[[
  contains autocommands related to window resizing
--]]

local Autocmd = require 'utils.core.autocmd'
local Window = require 'utils.api.vim.window'

GetLogger('AUTOCMD'):info 'Creating resize autocmds'

---@note: nvim scales splits proportionally when its host terminal (i.e.: the tmux pane
--- it runs in) changes size, which lets layouts drift over successive resizes;
--- equalizing keeps them predictable
Autocmd.new()
  :withDesc('Equalizes window sizes when the host terminal/tmux pane is resized')
  :withEvent('VimResized')
  :withCallback(Window.equalize)
  :create()

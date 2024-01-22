-- workspace -------------------------------------------------------------------

--[[
  contains autocommands related to workspaces, i.e.: projects, session, etc.
--]]

local Autocmd = require 'utils.core.autocmd'
local Session = require 'utils.api.session'

GetLogger('AUTOCMD'):info 'Creating workspace autocmds'

local function load_cwd_session()
  Session.load()
  return true
end

-- NOTE:taking this responsibility from session manager since I can't get the plugin to
--- do what I want oob, i.e.: load the right session when I open nvim from a specific dir
Autocmd.new()
  :withDesc('Loads session on start for cwd')
  :withEvent('VimEnter')
  :withGroup('UserSession')
  :withOpt('nested', true)
  :withCallback(load_cwd_session)
  :create()

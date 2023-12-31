
-- workspace -------------------------------------------------------------------

--[[
  contains autocommands related to workspaces, i.e.: projects, session, etc.
--]]

local Session = require 'utils.api.session'
local Autocmd = require 'utils.core.autocmd'


InfoQuietly('Creating user workspace autocmds')

-- FIXME: see FIXME in Session.save
-- local function save_session()
--   Session.save()
--   return true
-- end
--
-- -- loads session for cwd; taking this responsibility from session manager since I can't
-- -- get the plugin to do what I want oob, i.e.: load the right session when I open nvim
-- -- from a specific dir
-- Autocmd.new()
--   :withDesc('Saves session on exit for cwd')
--   :withEvent('VimLeavePre')
--   :withGroup('UserSession')
--   :withOpt('nested', true)
--   :withCallback(save_session)
--   :create()

local function load_cwd_session()
  Session.load()
  return true
end

-- loads session for cwd; taking this responsibility from session manager since I can't
-- get the plugin to do what I want oob, i.e.: load the right session when I open nvim
-- from a specific dir
Autocmd.new()
  :withDesc('Loads session on start for cwd')
  :withEvent('VimEnter')
  :withGroup('UserSession')
  :withOpt('nested', true)
  :withCallback(load_cwd_session)
  :create()


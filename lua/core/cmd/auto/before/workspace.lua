
-- workspace -------------------------------------------------------------------

--[[
  contains autocommands related to workspaces, i.e.: projects, session, etc.
--]]

local System  = require 'utils.api.vim.system'
local Autocmd = require 'utils.core.autocmd'

local session_manager = require 'session_manager'


InfoQuietly({ 'Creating user workspace autocmds' })

local function set_cwd()
  local cwd = System.cwd()
  System.cd(cwd)

  DebugQuietly({ 'Cwd set to ', cwd })
  return true
end

-- to align nvim's cwd w/ the actual cwd
Autocmd.new()
  :withDesc('Changes cwd')
  :withEvent('VimEnter')
  :withGroup('UserWorkspace')
  :withCallback(set_cwd)
  :create()

local function load_cwd_session()
  session_manager.load_current_dir_session()

  DebugQuietly({ 'Loaded cwd session' })
  return true
end

-- loads session for cwd; taking this responsibility from session manager since I can't
-- get the plugin to do what I want oob, i.e.: load the right session when I open nvim
-- from a specific dir
Autocmd.new()
  :withDesc('Loads session for cwd')
  :withEvent('VimEnter')
  :withGroup('UserSession')
  :withOpt('nested', true)
  :withCallback(load_cwd_session)
  :create()

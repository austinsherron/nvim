
-- logs ------------------------------------------------------------------------

--[[
  contains user commands related to interacting w/ "user logs" (i.e.: where logger calls
  write)
--]]

local Buffer      = require 'utils.api.vim.buffer'
local UserCommand = require 'utils.core.usercmd'


local function do_open(view_mode)
  local log_path = GetLogger():log_path()
  Buffer.open(view_mode, log_path)
end


local function open_nvim_log(opts)
  local view_mode = Table.safeget(opts or {}, { 'fargs', 1 })
  do_open(view_mode)
end

UserCommand.new()
  :withName('UserLogs')
  :withCmd(Safe.ify(function(...) open_nvim_log(...) end, { prefix = 'UserLogs' }), '?')
  :withDesc('Opens the nvim user log; params: view_mode - optional; @see Buffer.ViewMode')
  :create()


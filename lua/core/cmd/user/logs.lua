-- logs ------------------------------------------------------------------------

--[[
  contains user commands related to interacting w/ "user logs" (i.e.: where logger calls
  write)
--]]

local LoggerType = require 'toolbox.log.type'
local Logs = require 'utils.api.logs'
local UserCommand = require 'utils.core.usercmd'

local ViewMode = require('utils.api.vim.buffer').ViewMode

local ArgParse = UserCommand.ArgParse

local function open_nvim_log(opts)
  local args = ArgParse.parse(opts)

  Logs.open({
    type = LoggerType.or_default(args.type),
    viewmode = ViewMode:or_default(args.viewmode),
  })
end

UserCommand.new()
  :withName('Logs')
  :withCmd(open_nvim_log, '?')
  :withDesc('Opens log=type; params: viewmode="viewmode" type="type"; @see Logs.open')
  :create()

UserCommand.new()
  :withName('LogsClose')
  :withCmd(Logs.close)
  :withDesc('Closes all open logs')
  :create()

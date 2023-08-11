
-- logs ------------------------------------------------------------------------

--[[
  contains user commands related to interacting w/ "user logs" (i.e.: where logger calls
  write)
--]]

local Buffer      = require 'utils.api.vim.buffer'
local UserCommand = require 'utils.core.usercmd'


local function do_open(view_mode)
  view_mode = Buffer.ViewMode.orDefault(view_mode)
  local log_path = GetLogger():log_path()

  Buffer.open(log_path, view_mode)
end


local function open_nvim_log(opts)
  opts = opts or {}

  local view_mode = ternary(
    Table.not_nil_or_empty(opts.fargs),
    function() return opts.fargs[1] end
  )

  do_open(view_mode)
end

UserCommand.new()
  :withName('UserLogs')
  :withCmd(Safe.ify(function(...) open_nvim_log(...) end), '?')
  :withDesc('Opens the nvim user log; params: view_mode - optional; @see Buffer.ViewMode')
  :create()


local AutoCommand = require 'utils.core.autocmd'
local UserCommand = require 'utils.core.usercmd'
local Session     = require 'utils.session.session'
local Safe        = require 'utils.error.safe'


local function save()
  -- Safe.call(function() Session.save() end, 'notify', 'Session')
  Session.save()
end


local function load(opts)
  -- Safe.call(function() Session.load(opts.fargs[1]) end, 'notify', 'Session')
  Session.load(opts.fargs[1])
end


local function delete(opts)
  -- Safe.call(function() Session.delete(opts.fargs[1]) end, 'notify', 'Session')
  Session.delete(opts.fargs[1])
end


local function list()
  -- Safe.call(function() Session.list() end, 'notify', 'Session')
  Session.list()
end


local SessionCmd = {}

function SessionCmd.usercmds()
  local cmd = UserCommand.new({ opts = {}})

  cmd:create({ name = 'SessionSave',   cmd = save })
  cmd:create({ name = 'SessionLoad',   cmd = load })
  cmd:create({ name = 'SessionDelete', cmd = delete })
  cmd:create({ name = 'SessionList',   cmd = list })
end


function SessionCmd.autocmds()
  AutoCommand.new()
    :withEvents({ 'VimEnter', 'DirChanged' })
    :withCallback(load)
    :withDesc('Restores a session on vim start and when cwd changes')
    :create()

  AutoCommand.new()
    :withEvents({ 'VimLeave', 'BufWritePost' })
    :withDesc('Saves a session on vim exit and when a buffer is saved')
    :withCallback(save)
    :create()
end

return SessionCmd


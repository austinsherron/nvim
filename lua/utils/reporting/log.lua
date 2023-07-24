local LogLevel = require 'lib.lua.log.level'
local Logger   = require 'lib.lua.log.logger'
local Path     = require 'utils.api.path'


return Logger.new(Path.log() .. 'nvim-user.log', LogLevel.default())


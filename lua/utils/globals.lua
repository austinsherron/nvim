local Lazy = require 'lib.lua.utils.lazy'


---@type fun(): l: Logger
GetLogger = Lazy.require('utils.reporting.logger')
---@type fun(): n: Notify
GetNotify = Lazy.require('utils.reporting.notify')


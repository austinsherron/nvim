---@note: we want global functions w/ lowercased names
---@diagnostic disable: lowercase-global

-- nvim config object
NvimConfig = require 'utils.config'

-- logger factory and notification service
local loggers = require 'utils.reporting.loggers'

GetLogger = loggers.GetLogger
-- GetNotify = loggers.GetNotify
GetNotify = function()
  return require 'utils.reporting.notify'
end

-- generally useful, oft imported utils
Array = require 'toolbox.core.array'
Bool = require 'toolbox.core.bool'
Dict = require 'toolbox.core.dict'
Stream = require 'toolbox.extensions.stream'
String = require 'toolbox.core.string'
Table = require 'toolbox.core.table'
Err = require 'toolbox.error.error'
Set = require 'toolbox.extensions.set'
Lazy = require 'toolbox.utils.lazy'
Map = require 'toolbox.utils.map'

-- error handling utils
OnErr = require 'toolbox.error.onerr'
Safe = require 'toolbox.error.safe'

-- generally useful, oft imported util functions
ternary = Bool.ternary
filter = Map.filter
foreach = Map.foreach
map = Map.map
fmt = String.fmt

GetLogger('INIT'):info 'Globals initialized'

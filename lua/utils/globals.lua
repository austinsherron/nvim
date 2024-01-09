---@note: we want global functions w/ lowercased names
---@diagnostic disable: lowercase-global

-- logger factory and notification service
GetLogger = require 'utils.reporting.loggers'
Notify = require 'utils.reporting.notify'

-- generally useful, oft imported utils
Array = require 'toolbox.core.array'
Bool = require 'toolbox.core.bool'
Dict = require 'toolbox.core.dict'
Stream = require 'toolbox.extensions.stream'
String = require 'toolbox.core.string'
Table = require 'toolbox.core.table'
Err = require 'toolbox.error.error'
Set = require 'toolbox.extensions.set'
Map = require 'toolbox.utils.map'
OnErr = require 'utils.error.onerr'
Safe = require 'utils.error.safe'

-- generally useful, oft imported util functions
ternary = Bool.ternary
filter = Map.filter
foreach = Map.foreach
map = Map.map
fmt = String.fmt

GetLogger('INIT'):info 'Globals initialized'

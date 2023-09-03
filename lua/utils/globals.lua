---@note: we want global functions w/ lowercased names
---@diagnostic disable: lowercase-global

-- logging utils
require 'utils.reporting.globals'

-- generally useful, oft imported utils
Array  = require 'toolbox.core.array'
Bool   = require 'toolbox.core.bool'
Dict   = require 'toolbox.core.dict'
String = require 'toolbox.core.string'
Table  = require 'toolbox.core.table'
Err    = require 'toolbox.error.error'
Set    = require 'toolbox.extensions.set'
OnErr  = require 'utils.error.onerr'
Safe   = require 'utils.error.safe'

-- generally useful, oft imported util functions
fmt     = String.fmt
ternary = Bool.ternary


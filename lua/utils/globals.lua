
-- logging utils
require 'utils.reporting.globals'

-- generally useful, oft imported utils
Bool   = require 'toolbox.core.bool'
String = require 'toolbox.core.string'
Table  = require 'toolbox.core.table'
Error  = require 'toolbox.error.error'
Set    = require 'toolbox.extensions.set'
OnErr  = require 'utils.error.onerr'
Safe   = require 'utils.error.safe'

---@diagnostic disable-next-line: lowercase-global
ternary = Bool.ternary


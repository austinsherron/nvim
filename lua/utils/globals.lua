local Lazy = require 'toolbox.utils.lazy'


-- logger ----------------------------------------------------------------------

---@type fun(): l: NvimLogger
GetLogger = Lazy.require('utils.reporting.logger')

-- global logging helpers
function Trace(...) GetLogger():trace(...) end
function Debug(...) GetLogger():debug(...) end
function Info (...) GetLogger():info (...) end
function Warn (...) GetLogger():warn (...) end
function Error(...) GetLogger():error(...) end

-- imports ---------------------------------------------------------------------

Bool   = require 'toolbox.core.bool'
String = require 'toolbox.core.string'
Table  = require 'toolbox.core.table'
Set    = require 'toolbox.extensions.set'
OnErr  = require 'utils.error.onerr'
Safe   = require 'utils.error.safe'

---@diagnostic disable-next-line: lowercase-global
ternary = Bool.ternary


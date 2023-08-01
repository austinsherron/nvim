local Lazy = require 'lib.lua.utils.lazy'


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

Bool   = require 'lib.lua.core.bool'
String = require 'lib.lua.core.string'
Table  = require 'lib.lua.core.table'
Set    = require 'lib.lua.extensions.set'
OnErr  = require 'utils.error.onerr'
Safe   = require 'utils.error.safe'

ternary = Bool.ternary


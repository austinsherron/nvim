local Lazy = require 'lib.lua.utils.lazy'


---@type fun(): l: NvimLogger
GetLogger = Lazy.require('utils.reporting.logger')

-- global logging helpers
function Trace(...) GetLogger():trace(...) end
function Debug(...) GetLogger():debug(...) end
function Info (...) GetLogger():info (...) end
function Warn (...) GetLogger():warn (...) end
function Error(...) GetLogger():error(...) end


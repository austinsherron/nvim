local Lazy = require 'lib.lua.utils.lazy'


---@type fun(): l: Logger
local getLogger = Lazy.require('utils.reporting.logger')

-- global logging helpers
function Trace(...) getLogger():trace(...) end
function Debug(...) getLogger():debug(...) end
function Info (...) getLogger():info (...) end
function Warn (...) getLogger():warn (...) end
function Error(...) getLogger():error(...) end


local onerr = require 'utils.errorhandling.onerr'


--- Provides methods for "safely" performing various actions. In this context, "safely"
--  means "w/ error handling".
--
---@class Safe
local Safe = {}

--- Basically pcall w/ mandatory error handling.
--
---@see OnErr
--
---@param to_call fun(): r: any?: the function to call
---@param error_handler OnErrStrategy?: how to handle errors; defaults to "notify"
---@param prefix string?: optional prefix for error msg
---@return any?: the value returned by to_call
function Safe.call(to_call, error_handler, prefix)
  error_handler = error_handler or 'notify'
  return onerr[error_handler](to_call, prefix)
end


--- Standard lua require wrapped w/ mandatory error handling.
--
---@see OnErr
--
---@param to_require string: the import string that references a lua module to require (import)
---@param and_then (fun(m: any?): r: any?)?: optional function to call on the result of the require
---@param error_handler OnErrStrategy?: how to handle errors; defaults to "notify"
---@param prefix string?: optional prefix for error msg
---@return any?: the value returned by the required module, or nil if there's an error
function Safe.require(to_require, and_then, error_handler, prefix)
  local to_call = function() return require(to_require) end
  local m = Safe.call(to_call, error_handler, prefix)

  if not and_then then
    return m
  end

  return Safe.call(function() return and_then(m) end, error_handler, prefix)
end

return Safe


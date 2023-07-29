local Bool = require 'lib.lua.core.bool'


local function make_err_msg(err_res, prefix)
  prefix = Bool.ternary(prefix == nil, '', function() return prefix .. ': ' end)
  return prefix .. (err_res or '')
end

-- A type alias that allows enforcement of passing specific method names to functions that
-- accept them as arguments.
--
-- TODO: figure out if there's a better way to achieve the above goal w/out hard-coding
--       method names.
--
---@alias OnErrStrategy
---| "log"       # see OnErr.log
---| "notify"    # see OnErr.notify

--- Contains utility methods that wrap function calls and perform specific actions when the
--  functions raise errors.
--
---@class OnErr
local OnErr = {}

--- On error, logs the error message.
--
---@param f fun(): any?: the function that might throw an error
---@param prefix string?: optional prefix for error msg
function OnErr.log(f, prefix)
  local ok, res = pcall(f)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  Error(err_msg, { user_facing = false })
end


--- On error, displays a notification w/ the error message.
--
---@param f fun(): any?: the function that might throw an error
---@param prefix string?: optional prefix for error msg
function OnErr.notify(f, prefix)
  local ok, res = pcall(f)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  -- not necessary, but want to be explicit about the fact that we're logging a
  -- user-facing message here
  Error(err_msg, { user_facing = true })
end


--- On error, returns false.
--
---@param f fun(): any?: the function that might throw an error
---@return boolean: true if the function completes w/out error, false otherwise
---@return any?: the result of f, if any
function OnErr.return_false(f)
  local ok, res = pcall(f)
  return ok, res
end

return OnErr


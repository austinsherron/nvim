-- TODO: update api so callers can specify sub-logger
local LOGGER = GetLogger()

--- A type alias that allows enforcement of passing specific method names to functions that
--- accept them as arguments.
---
--- TODO: figure out if there's a better way to achieve the above goal w/out hard-coding
---       method names.
---
---@alias OnErrStrategy
---| "log"       # see OnErr.log
---| "notify"    # see OnErr.notify

--- Contains utility methods that wrap function calls and perform specific actions when the
--- functions raise errors.
---
---@class OnErr
local OnErr = {}

local function make_err_msg(err_res, prefix)
  err_res = err_res or ''

  prefix = ternary(prefix == nil, '', function()
    return prefix .. ': '
  end)
  return prefix .. err_res
end

local function make_title(prefix)
  local title = 'Error encountered'

  return ternary(String.nil_or_empty(prefix), title, function()
    return title .. ' in ' .. prefix
  end)
end

--- On error, logs the error message.
---
---@param f function: the function that might throw an error
---@param prefix string?: optional prefix for error msg
---@param ... any?: args to pass to f
function OnErr.log(f, prefix, ...)
  local ok, res = xpcall(f, debug.traceback, ...)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  LOGGER:error(err_msg, {}, { user_facing = false })
end

--- On error, displays a notification w/ the error message.
---
---@param f function: the function that might throw an error
---@param prefix string?: optional prefix for error msg
---@param ... any?: args to pass to f
function OnErr.notify(f, prefix, ...)
  local ok, res = xpcall(f, debug.traceback, ...)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  -- not necessary, but want to be explicit about the fact that we're logging a
  -- user-facing message here
  LOGGER:error(err_msg, {}, { user_facing = true, title = make_title(prefix) })
end

return OnErr

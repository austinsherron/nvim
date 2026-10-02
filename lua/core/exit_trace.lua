---- exit trace ----------------------------------------------------------------

--[[
  Records which code shells out while neovim is exiting.

  Neovim's exit path is not re-entrant, but `system()` and `systemlist()` pump the
  event loop while they wait on their child. That re-delivers the exit event and
  re-enters `getout`, which runs the exit autocmds again, which shell out again. The
  loop does not terminate, and the lua heap grows w/out bound.

  This module logs every blocking shell-out that runs after the exit starts, w/ a
  traceback, so the log names the responsible plugin. It also counts how many times
  each exit event fires. A count above one is the re-entrant exit itself.

  Two deliberate deviations from the repo's conventions:

  1. It wraps the raw `vim.call` rather than a `utils.api` wrapper. `vim.fn.<name>`
     resolves `vim.call` at call time, so this one hook catches every caller, incl.
     plugins that captured `vim.fn.system` before this module loaded.
  2. It uses no config globals and writes its own log file instead of using
     `GetLogger`. The exit loop is what we are measuring, so the trace must not
     depend on config machinery that the loop itself is stressing.

  Set NVIM_EXIT_TRACE=0 in the environment to disable.
--]]

local LOG_PATH = vim.fn.stdpath 'state' .. '/exit-trace.log'
local MAX_ARG_CHARS = 240
local MAX_DISTINCT = 50
local MAX_EVENT_LOGS = 40
local PROGRESS_EVERY = 500
local PID = vim.uv.getpid()

--- Names of vim functions that block on a child process while pumping the event
--- loop. These are the calls that can re-enter the exit path.
local BLOCKING = {
  system = true,
  systemlist = true,
  jobwait = true,
}

local exiting = false
local calls = 0
local distinct = 0
local events = {}
local seen = {}

---@param line string: the line to append to the trace log
local function append(line)
  pcall(function()
    local file = io.open(LOG_PATH, 'a')

    if file == nil then
      return
    end

    file:write(line, '\n')
    file:flush()
    file:close()
  end)
end

---@return string: the current local time, formatted for the trace log
local function stamp()
  return os.date '%Y-%m-%d %H:%M:%S'
end

---@param ... any: the args passed to the traced call
---@return string: a bounded, single-line rendering of the call's first arg
local function describe(...)
  local ok, rendered = pcall(vim.inspect, (select(1, ...)))

  if not ok then
    return '<uninspectable>'
  end

  rendered = rendered:gsub('%s+', ' ')

  if #rendered > MAX_ARG_CHARS then
    return rendered:sub(1, MAX_ARG_CHARS) .. '...'
  end

  return rendered
end

---@param name string: the name of the vim function being called
---@param ... any: the args passed to it
local function record(name, ...)
  calls = calls + 1

  local traceback = debug.traceback('', 3)

  if seen[traceback] == nil and distinct < MAX_DISTINCT then
    distinct = distinct + 1
    seen[traceback] = true

    append(
      string.format(
        '[%s] pid=%d call #%d during exit: %s(%s)%s',
        stamp(),
        PID,
        calls,
        name,
        describe(...),
        traceback
      )
    )
  end

  if calls % PROGRESS_EVERY == 0 then
    append(
      string.format(
        '[%s] pid=%d %d blocking calls since exit started',
        stamp(),
        PID,
        calls
      )
    )
  end
end

---@param args table: the args neovim passes to an autocmd callback
local function on_event(args)
  if args.event ~= 'VimSuspend' then
    exiting = true
  end

  local count = (events[args.event] or 0) + 1
  events[args.event] = count

  if count > MAX_EVENT_LOGS then
    return
  end

  local note = count > 1 and ' RE-ENTRANT' or ''

  append(
    string.format(
      '[%s] pid=%d %s fired, count=%d%s%s',
      stamp(),
      PID,
      args.event,
      count,
      note,
      debug.traceback('', 2)
    )
  )
end

--- Logs blocking shell-outs that happen during neovim's exit sequence.
---
---@class ExitTrace
local ExitTrace = {}

--- Wraps `vim.call` and registers the exit autocmds. Call once, before plugins
--- load, so the trace sees every caller.
function ExitTrace.setup()
  if vim.env.NVIM_EXIT_TRACE == '0' then
    return
  end

  local call = vim.call

  vim.call = function(name, ...)
    if exiting and BLOCKING[name] then
      record(name, ...)
    end

    return call(name, ...)
  end

  vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimLeave', 'VimSuspend' }, {
    desc = 'Trace blocking shell-outs during exit',
    group = vim.api.nvim_create_augroup('ExitTrace', { clear = true }),
    callback = on_event,
  })

  append(string.format('[%s] pid=%d exit trace armed', stamp(), PID))
end

return ExitTrace

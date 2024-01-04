local Buffer  = require 'utils.api.vim.buffer'
local System  = require 'utils.api.vim.system'
local Tab     = require 'utils.api.vim.tab'
local Window  = require 'utils.api.vim.window'

local Collectors   = Stream.Collectors
local WindowBuffer = Window.WindowBuffer


--- Contains utilities for inspecting nvim state.
---
---@class Inspect
local Inspect = {}

--- Displays info the cwd.
function Inspect.cwd()
  Info(
    'CWD: %s',
    { System.cwd() },
    { title = 'CWD' }
  )
end

local BUFFER_TEMPLATE = [[
- Buffer ID: %s
- Name: %s
- Type: %s
- Filetype: %s
]]

local INSPECT_TEMPLATE = [[
Current %s:

%s
]]

local function fmtbuf(buf, indent)
  indent = indent or '  '

  local bufstr = fmt(
    BUFFER_TEMPLATE,
    buf.id, buf.name, buf.type, buf.filetype
  )

  return indent .. String.join(String.split_lines(bufstr) or {}, '\n' .. indent)
end


--- Displays info about the current buffer.
function Inspect.buffer()
  local buf = Buffer.info()
  local bufstr = fmtbuf(buf)

  Info(
    INSPECT_TEMPLATE,
    { 'buffer', bufstr },
    { title = 'Current Buffer' }
  )
end

local WINDOW_TEMPLATE = [[
%s- Window ID: %s
%s- Buffer:
%s
]]

local function fmtwin(winbuf, indent)
  indent = indent or '  '

  local bufstr = fmtbuf(winbuf.buffer, indent .. '  ')
  return fmt(
    WINDOW_TEMPLATE,
    indent,
    winbuf.id,
    indent,
    bufstr
  )
end


--- Displays info about the current window.
function Inspect.window()
  local winbuf = Window.buffer()
  local winstr = fmtwin(winbuf, '    ')

  Info(
    INSPECT_TEMPLATE,
    { 'window', winstr },
    { title = 'Current Window' }
  )
end

local TAB_TEMPLATE = [[
Current Tab:

  - Tab ID: %s
  - Window(s):

%s
]]

--- Displays info about the current tab.
function Inspect.tab()
  local tab = Tab.current()
  local winstrs = Stream.new(Tab.windows(tab))
    :map(WindowBuffer.new)
    :map(function(w) return fmtwin(w, '    ') end)
    :collect(Collectors.joining('\n'))

  Info(
    TAB_TEMPLATE,
    { tab, winstrs },
    { title = 'Current Tab' }
  )
end

return Inspect


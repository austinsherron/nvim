local Buffer = require 'utils.api.vim.buffer'
local Env = require 'toolbox.system.env'
local Interaction = require 'utils.api.vim.interaction'
local Session = require 'utils.api.session'
local System = require 'utils.api.vim.system'
local Tab = require 'utils.api.vim.tab'
local Window = require 'utils.api.vim.window'

local Collectors = Stream.Collectors
local WindowBuffer = Window.WindowBuffer

--- Contains utilities for inspecting nvim state.
---
---@class Inspect
local Inspect = {}

--- Displays info the cwd.
function Inspect.cwd()
  GetNotify().info('CWD: %s', { System.cwd() }, { title = 'CWD' })
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

  local bufstr = fmt(BUFFER_TEMPLATE, buf.id, buf.name, buf.type, buf.filetype)

  return indent .. String.join(String.split_lines(bufstr) or {}, '\n' .. indent)
end

--- Displays info about the current buffer.
function Inspect.buffer()
  local buf = Buffer.info()
  local bufstr = fmtbuf(buf)

  GetNotify().info(INSPECT_TEMPLATE, { 'buffer', bufstr }, { title = 'Current Buffer' })
end

local WINDOW_TEMPLATE = [[
%s- Window ID: %s
%s- Buffer:
%s
]]

local function fmtwin(winbuf, indent)
  indent = indent or '  '

  local bufstr = fmtbuf(winbuf.buffer, indent .. '  ')
  return fmt(WINDOW_TEMPLATE, indent, winbuf.id, indent, bufstr)
end

--- Displays info about the current window.
function Inspect.window()
  local winbuf = Window.buffer()
  local winstr = fmtwin(winbuf, '    ')

  GetNotify().info(INSPECT_TEMPLATE, { 'window', winstr }, { title = 'Current Window' })
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
    :map(function(w)
      return fmtwin(w, '    ')
    end)
    :collect(Collectors.joining '\n')

  GetNotify().info(TAB_TEMPLATE, { tab, winstrs }, { title = 'Current Tab' })
end

--- Displays info about the highlight group(s) applied to entity under the cursor, if any.
function Inspect.highlight()
  vim.api.nvim_command 'TSHighlightCapturesUnderCursor'
end

local SESSION_TEMPLATE = [[
Current Session%s:

  - Name: %s
  - Path: %s
  - Dir: %s

]]

--- Displays session info, either based on the CWD or global session state.
function Inspect.session()
  Interaction.selection_dialog('Session', { 'CWD', 'Global' }, function(selection)
    if selection == nil then
      return
    end

    local global = selection == 'Global'

    local session = Session.current(global)
    local opts = { title = 'Current Session' }

    if session == nil then
      return GetNotify().info('No active session', {}, opts)
    end

    GetNotify().info(SESSION_TEMPLATE, {
      ternary(global == true, ' (Global)', ''),
      session.name,
      session.file_path,
      session.dir_path,
    }, opts)
  end)
end

--- Displays the value of the global variable typed in the prompt.
function Inspect.global()
  local name, forcequit = Interaction.input('Global Variable', { required = true })

  if forcequit == true then
    return
  end

  local val = String.tostring(vim.g[name])
  GetNotify().info('%s=%s', { name, val }, { title = 'Global Variable' })
end
--- Displays the value of the env variable typed in the prompt.
function Inspect.env()
  local name, forcequit = Interaction.input('Env Variable', { required = true })

  if forcequit == true then
    return
  end

  local val = String.tostring(Env[name])
  GetNotify().info('%s=%s', { name, val }, { title = 'Env Variable' })
end

return Inspect

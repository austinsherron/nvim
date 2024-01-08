
-- repl ------------------------------------------------------------------------

--[[
  contains user commands related to interacting w/ in editor lua repl (neorepl,
  at the time of writing)
--]]

local NeoRepl     = require 'plugins.config.tools.neorepl'
local Buffer      = require 'utils.api.vim.buffer'
local UserCommand = require 'utils.core.usercmd'

local ViewMode = Buffer.ViewMode
local ArgParse = UserCommand.ArgParse


local function start_lua_repl(opts)
  local args = ArgParse.parse(opts)
  local viewmode = args[1]

  if viewmode ~= nil then
    Buffer.open(ViewMode:or_default(viewmode))
  end

  require('neorepl').new(NeoRepl.opts())
end

UserCommand.new()
  :withName('Repl')
  :withCmd(Safe.ify(function(...) start_lua_repl(...) end), '?')
  :withDesc('Opens a lua repl in a new buffer/window')
  :create()


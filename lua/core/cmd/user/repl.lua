
-- repl ------------------------------------------------------------------------

--[[
  contains user commands related to interacting w/ in editor lua repl (neorepl,
  at the time of writing)
--]]

local NeoRepl     = require 'plugins.config.tools.neorepl'
local Buffer      = require 'utils.api.vim.buffer'
local UserCommand = require 'utils.core.usercmd'


local function do_start_lua_repl(view_mode)
  if view_mode ~= nil then
    Buffer.open(view_mode)
  end

  require('neorepl').new(NeoRepl.opts())
end


local function start_lua_repl(opts)
  local view_mode = Table.safeget(opts or {}, { 'fargs', 1 })
  do_start_lua_repl(view_mode)
end

UserCommand.new()
  :withName('Repl')
  :withCmd(Safe.ify(function(...) start_lua_repl(...) end), '?')
  :withDesc('Opens a lua repl in a new nvim buffer/window')
  :create()


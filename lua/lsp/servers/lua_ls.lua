local env = require('lib.lua.system.env')
local path = require('lib.lua.system.path')
local str = require('lib.lua.core.string')
local stream = require('lib.lua.utils.stream')


local function get_lua_path_components()
---@diagnostic disable-next-line: undefined-field
  local lua_path = env.lua_path()
  local split_lua_path = str.split(lua_path, ';')

  return stream(split_lua_path)
---@diagnostic disable-next-line: undefined-field
      :filter(function(i) return i ~= '' end)
      :get()
end


local function make_wkspace_library()
---@diagnostic disable-next-line: undefined-field
  local projects_root = env.projects_root()
---@diagnostic disable-next-line: undefined-field
  local nvim_root = env.nvim_root()

  return {
    nvim_root,
    projects_root .. '/lua/',
  }
end


return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      runtime = {
        version = 'Lua 5.3',
        path = get_lua_path_components(),
      },
      workspace = {
        library = make_wkspace_library(),
      }
    }
  }
}


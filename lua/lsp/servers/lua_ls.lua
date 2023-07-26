local String =  require 'lib.lua.core.string'
local Table  =  require 'lib.lua.core.table'
local Set    =  require 'lib.lua.extensions.set'
local Env    =  require 'lib.lua.system.env'
local Stream =  require 'lib.lua.utils.stream'

local get_nvim_runtime_files = vim.api.nvim_get_runtime_file


local function get_lua_path()
  local lua_path = Env.lua_path()
  local split_lua_path = String.split(lua_path, ';')

  return Stream(split_lua_path)
    :filter(function(i) return i ~= '' end)
    :map(function(i) return String.trim_after(i, '?') end)
    -- to dedup
    :collect(Set.new)
    :entries()
end


local function get_wkspace_lib()
  return Table.concat({
    get_lua_path(),
    get_nvim_runtime_files('', true),
  })
end


return {
  settings = {
    Lua = {
      runtime = {
        -- tell the language server which version of lua we're using (most likely luajit in the case of neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- so vim global is recognized
        globals = { 'vim' },
      },
      workspace = {
        -- make server aware of neovim runtime files
        library         = get_wkspace_lib(),
        checkThirdParty = false,
      },
      -- don't send telemetry data (contains a randomized but unique identifier)
      telemetry = {
        enable = false,
      },
    },
  },
}


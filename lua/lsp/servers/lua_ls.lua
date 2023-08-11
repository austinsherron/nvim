local Stream = require 'toolbox.extensions.stream'
local Env    = require 'toolbox.system.env'

local get_nvim_runtime_files = vim.api.nvim_get_runtime_file


local function get_lua_path(trim_wild)
  local lua_path = Env.lua_path()
  local split_lua_path = String.split(lua_path, ';')

  local trimmer = ternary(
    trim_wild,
    function() return function(i) return String.trim_after(i, '?') end end,
    function() return function(i) return i end end
  )

  return Stream(split_lua_path)
    :filter(function(i) return i ~= '' end)
    :map(trimmer)
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
        path    = get_lua_path(false),
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


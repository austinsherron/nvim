local Stream = require 'toolbox.extensions.stream'
local Env    = require 'toolbox.system.env'


local function filter_lua_runtime_path(path)
  local nvim_root_pub = Env.nvim_root_pub()
  local nvim_submodule = Env.nvim_submodule()

  -- avoid including "deployed" nvim files
  return not String.startswith(
    path,
    nvim_root_pub
  -- avoid including files from the nvim dotfiles submodule
  ) and not String.startswith(
    path,
    nvim_submodule
  )
end


local function get_trimmer(trim_wild)
  return ternary(
    trim_wild,
    function() return function(i) return String.trim_after(i, '?') end end,
    function() return function(i) return i end end
  )
end


local function get_lua_path(trim_wild)
  trim_wild = trim_wild or false

  local lua_path = Env.lua_path()
  local split_lua_path = String.split(lua_path, ';')
  local trimmer = get_trimmer(trim_wild)

  return Stream(split_lua_path)
    :filter(function(i) return i ~= '' end)
    :filter(function(p) return filter_lua_runtime_path(p) end)
    :map(trimmer)
    -- to dedup
    :collect(Set.new)
    :entries()
end


local function get_internal_wkspace_lib()
  return {
    Env.code_root() .. '/lib/lua',
    Env.code_root() .. '/snippets/lua/',
  }
end


local function get_runtime_files()
   return Stream(get_lua_path(true))
     :filter(function(p) return filter_lua_runtime_path(p) end)
     :get()
 end


local function get_wkspace_lib()
  return Stream(Table.concat({ get_internal_wkspace_lib(), {}}))   -- get_runtime_files() }))
    :peek(function(i) DebugQuietly({ 'Adding file=', i, ' to lua_ls workspace.library'}) end)
    :get()
end


return {
  settings = {
    Lua = {
      diagnostics = {
        -- so vim global is recognized
        globals = { 'vim' },
      },
      runtime = {
        path    = get_lua_path(false),
        -- tell the language server which version of lua we're using (most likely luajit in the case of neovim)
        version = 'LuaJIT',
      },
      -- don't send telemetry data (contains a randomized but unique identifier)
      telemetry = {
        enable = false,
      },
      workspace = {
        -- so we're not asked about adding libraries to workspace every time we open nvim
        checkThirdParty = false,
        -- make server aware of neovim runtime files
        library         = get_wkspace_lib(),
      },
    },
  },
}


local Env = require 'toolbox.system.env'

local LOGGER = GetLogger 'LUA_LS'

local function get_internal_wkspace_lib()
  return {
    Env.code_root() .. '/lua-tools/lua',
    Env.code_root() .. '/snippets/lua/',
    Env.config_root_pub() .. '/hammerspoon/Spoons/EmmyLua.spoon/annotations',
  }
end

local function log(path)
  LOGGER:debug('Adding file=%s to workspace.library', { path })
end

local function get_wkspace_lib()
  return Stream.new(Table.concat({ get_internal_wkspace_lib(), {} })):peek(log):collect()
end

return {
  single_file_support = true,
  settings = {
    Lua = {
      completion = {
        workspaceWord = true,
        callSnippet = 'Both',
      },
      diagnostics = {
        -- so lua_ls doesn't complain about unrecognized globals (i.e.: vim, busted >
        -- describe/it, etc...)
        globals = {
          {
            -- for neovim
            'vim',
            -- for busted
            'assert',
            'describe',
            'it',
            'spy',
          },
        },
      },
      hint = {
        enable = true,
        arrayIndex = 'Disable',
        paramName = 'All',
        paramType = true,
        semicolon = 'Disable',
        setType = false,
      },
      hover = {
        expandAlias = true,
      },
      runtime = {
        pathStrict = true,
        -- tell the language server which version of lua we're using (most likely luajit
        -- in the case of neovim)
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
        library = get_wkspace_lib(),
      },
    },
  },
}


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
        library         = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- don't send telemetry data (contains a randomized but unique identifier)
      telemetry = {
        enable = false,
      },
    },
  },
}


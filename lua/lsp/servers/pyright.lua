---@type vim.lsp.Config
return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        typeCheckingMode = 'off',
        diagnosticSeverityOverrides = {
          reportMissingImports = 'error',
          reportUndefinedVariable = 'error',
        },
      },
    },
  },
}

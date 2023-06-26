local function build()
  return {
    with_sync = true,
    ensure_installed = {
      'bash',
      'go',
      'gomod',
      'gosum',
      'hcl',
      'help',
      'javascript',
      'json',
      'lua',
      'markdown',
      'python',
      'query',
      'sql',
      'terraform',
      'typescript',
      'vim',
      'yaml'
    },
  }
end


local function config()
  return {
    auto_install = false,
    context_commentstring = { enable = true, enable_autocmd = false },
    highlight = { enable = true },
    ignore_install = {},
    indent = { enable = true }, -- , disable = { "python" } },
    parser_install_dir = os.getenv('NVUNDLE'),
    sync_install = false,
  }
end


return {
  build = build,
  config = config,
}


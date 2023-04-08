function treesitter_opts()
  return {
    build = {
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
    },
    config = {
      context_commentstring = { enable = true, enable_autocmd = false },
      highlight = { enable = true },
      indent = { enable = true }, -- , disable = { "python" } },
      sync_install = false,
      auto_install = false,
      ignore_install = {},
      parser_install_dir = os.getenv('NVUNDLE'),
    },
  }
end


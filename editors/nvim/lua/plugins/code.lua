-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand and interact w/ code
--]]

require 'nvim.lua.plugins.config.treesitter'


function lspconfig_setup()
  require('lspconfig')setup()
  require('lspconfig').pyright.setup()
end


return {
---- lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  {
    'neovim/nvim-lspconfig',
    setup = lspconfig_setup,
  },
---- treesitter: a parser that integrates w/ all kinds of things (i.e.: adds extra color, etc.)
  {
    'nvim-treesitter/nvim-treesitter',
    opts = treesitter_opts(),

    build = function(_, opts)
      require('nvim-treesitter.install').update(opts.build)
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts.config)
    end,
  },
}

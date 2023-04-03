require 'lib.lua.table'
require 'nvim.lua.config.keymappings.gitsigns'
require 'nvim.lua.plugins.config.gitsigns'
require 'nvim.lua.plugins.config.nvimtree'
require 'nvim.lua.plugins.config.treesitter'


function alpha_nvim_config()
  require('alpha').setup(require('alpha.themes.startify').config)
end


function nvim_tree_config() 
  require('nvim-tree').setup(nvim_tree_settings()) 
end


function gitsigns_config() 
  local all_settings = table.combine(
    { on_attach = gitsigns_on_attach }, gitsigns_settings()
  )

  require('gitsigns').setup(all_settings)
end


function treesitter_build()
  require('nvim-treesitter.install').update({ with_sync = true })
end


function treesitter_setup()
  require('nvim-treesitter.lua.nvim-treesitter.configs')
    .setup(treesitter_settings())
end


return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = alpha_nvim_config  
  },
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '^1.0.0',     -- optional: only update when a new 1.x version is released
  },
  {
    'lewis6991/gitsigns.nvim',
    config = gitsigns_config,
  },
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = nvim_tree_config,
  },  
  {
    'nvim-treesitter/nvim-treesitter',
    build = treesitter_build,
    setup = treesitter_setup,
  },
}


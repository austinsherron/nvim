require 'nvim.lua.plugins.config.nvimtree'


function treesitter_build()
  require('nvim-treesitter.install').update({ with_sync = true })
end


function nvimtree_config() 
  require('nvim-tree').setup(nvimtree_settings()) 
end


return {
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = treesitter_build,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = nvimtree_config,
  },  
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '^1.0.0',     -- optional: only update when a new 1.x version is released
  },
}


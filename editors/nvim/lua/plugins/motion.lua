-- motion ----------------------------------------------------------------------

--[[
   control on-screen (as opposed to file-system) movement
--]]


return {
---- leap: fast movement w/in files
   { 
      'ggandor/leap.nvim',
      lazy = false,

      config = function()
        require('leap').add_default_mappings()
      end
   },
---- nvim-tmux navigation: integration b/w nvim + tmux (pane nav shortcuts) (TODO: seems broken...)
  {
    'alexghergh/nvim-tmux-navigation',
    opts = nvim_tmux_nav_opts(),

    config = function(_, opts) 
      require('nvim-tmux-navigation').setup(opts)
    end
  },
}


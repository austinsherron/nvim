-- appearance ------------------------------------------------------------------

--[[
  control how nvim looks: colors, icons, textures, menus, etc; distinct from
  interface in that interface elements should be functional (and ideally
  useful); appearance is the place for things that provide aesthetic value only
--]]

local lk = require 'nvim.lua.plugins.config.lspkind'
local plugin = require 'nvim.lua.utils.plugin'


return {
---- colorschemes
  plugin({ 'catppuccin/nvim' }),
  plugin({ 'rebelot/kanagawa.nvim' }),
  plugin({ 'AlexvZyl/nordic.nvim' }),
  plugin({ 'folke/tokyonight.nvim' }),
---- lspkind: icons for lsp completion items
  plugin({
    'onsails/lspkind.nvim',
    opts = lk.opts(),

    config = function(_, opts)
      require('lspkind').init(opts)
    end
  }),
---- nui: ui components
  plugin({ 'MunifTanjim/nui.nvim' }),
}


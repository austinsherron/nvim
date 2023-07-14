-- appearance ------------------------------------------------------------------

--[[
  control how nvim looks: colors, icons, textures, menus, etc; distinct from
  interface in that interface elements should be functional (and ideally
  useful); appearance is the place for things that provide aesthetic value only
--]]

local lk = require 'nvim.lua.plugins.config.lspkind'
local plugins = require('nvim.lua.utils.plugins.plugin').plugins


return plugins({
---- colorschemes
  { 'catppuccin/nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'AlexvZyl/nordic.nvim' },
  { 'folke/tokyonight.nvim' },
---- lspkind: icons for lsp completion items
  {
    'onsails/lspkind.nvim',
    opts = lk.opts(),

    config = function(_, opts)
      require('lspkind').init(opts)
    end
  },
---- nui: ui components
  { 'MunifTanjim/nui.nvim' },
})


-- tools -----------------------------------------------------------------------

--[[
  plugins for misc tools that add explicitly new functionality to nvim, as
  opposed to changing something about the way its core functions work; tools
  here don't fit into any other categories into which I've group "tool-type"
  plugins
--]]


return {
---- markdown preview: for previewing markdown documents 🤔
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install'
  },
---- TODO: template.nvim: file templates (I couldn't get this to work; revisit)
  {
    'glepnir/template.nvim',
    enabled = false,
    cmd = { 'Template', 'TemProject' },

    config = function()
      require('template').setup({
        name = 'Austin Sherron',
        email = 'dev@pryv.us',
        temp_dir = vim.fn.stdpath('config') .. '/.templates',
      })
    end
  },
}


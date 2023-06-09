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
}


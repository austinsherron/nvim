-- editor ----------------------------------------------------------------------

--[[
  control core editor capabilities like commenting, general text manipulation, etc.
--]]

return {
---- comment: manipulate code comments easily
  { 
    'numToStr/Comment.nvim',

    config = function() 
      require('Comment').setup() 
    end
  },
---- surround: efficient manipulation of brackets, quotes, etc.
  {
    'kylechui/nvim-surround',
    version = '*', -- use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',

    config = function()
      require('nvim-surround').setup()
    end
  },
}


local Priority = require 'utils.plugins.priority'


--- Util class for colorscheme plugins. Helps maintain consistency of props that should
--- change together.
---
---@class ColorScheme
local ColorScheme = {}
ColorScheme.__index = ColorScheme

--- Constructor
---
---@param git_path string: git repo path
---@return ColorScheme: a new instance
function ColorScheme.new(git_path)
  InfoQuietly('Initializaing colorscheme="%s"', { git_path })

  return setmetatable({
    git_path,
    lazy     = false,
    -- colorschemes are loaded w/ high priority, as discussed here:
    -- https://github.com/folke/lazy.nvim > Plugin Spec > priority
    priority = Priority.THIRD,
  }, ColorScheme)
end


--- Adds a "config" function to the colorscheme.
---
---@param pkg string: the name of the package to import for setup
---@param opts table|nil: optional, defaults to nil; additional colorscheme configuration
---@return ColorScheme: self
function ColorScheme:configure(pkg, opts)
  InfoQuietly('Configuring colorscheme="%s"', { pkg })
  Debug('Colorscheme opts=%s', { opts })

  self.config = function()
    require(pkg).setup(opts)
  end

  return self
end

return ColorScheme.new


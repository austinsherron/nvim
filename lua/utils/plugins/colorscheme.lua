local Bool     = require 'toolbox.core.bool'
local Priority = require 'utils.plugins.priority'


---@note: the name "ColorScheme" seems to clash w/ a similarly name class from tokyonight
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias ColorScheme { [1]: string, lazy: boolean, priority: Priority, config: fun(_, opts: table) }
---@alias ColorSchemeConfig { pkg: string, opts: table }

---@class ColorSchemeConfigurator
---@field config fun(): ColorSchemeConfig

local function configure_if_necessary(cs, config)
  if config == nil then
    return cs
  end

  Debug('Configuring colorscheme="%s"', { config.pkg })
  Trace('Colorscheme opts=%s', { config.opts })

  cs.opts = config.opts
  cs.config = function(_, opts)
    Safe.call(function() require(config.pkg).setup(opts) end)
  end

  return cs
end


--- Util function for constructing colorscheme plugins. Helps maintain consistency of
--- props that should change together.
---
---@param git_path string: git repo path
---@param config ColorSchemeConfig|nil: colorscheme config settings
---@param enabled boolean|nil: optional, defaults to true; if false, the colorscheme
--- plugin will be disabled
---@return table: a lazy.nvim representation of a colorscheme plugin
function ColorScheme(git_path, config, enabled)
  Debug('Initializing colorscheme="%s"', { git_path })

  enabled = Bool.or_default(enabled, true)

  return configure_if_necessary({
    git_path,
    enabled  = enabled,
    lazy     = false,
    -- colorschemes are loaded w/ high priority, as discussed here:
    -- https://github.com/folke/lazy.nvim > Plugin Spec > priority
    priority = Priority.THIRD,
  }, config)
end

return ColorScheme


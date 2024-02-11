local Import = require 'toolbox.utils.import'
local LspManager = require 'lsp.manager'

local LOGGER = GetLogger 'EFM'

local function get_efm_config(type, component)
  local module = fmt('efmls-configs.%ss.%s', type, component)

  if Import.does_module_exist(module) then
    return Safe:require(module)
  end

  LOGGER:warn('No efmls-config found for type=%s, component=%s', { type, component })
end

local function log(type, lang, name, config)
  LOGGER:debug('%s config for lang=%s, name=%s: %s', {
    String.capitalize(type),
    lang,
    name,
    config,
  })
end

local function make_component_config(components, type, configs)
  configs = configs or {}

  for lang, names in pairs(components) do
    for _, name in ipairs(names) do
      local config = configs[lang] or {}
      local efmconfig = get_efm_config(type, name)

      if efmconfig ~= nil then
        Array.append(config, get_efm_config(type, name))
        configs[lang] = config

        log(type, lang, name, config)
      end
    end
  end

  return configs
end

local function make_langagues_block()
  local configs = make_component_config(LspManager.formatters(), 'formatter')
  return make_component_config(LspManager.linters(), 'linter', configs)
end

return {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/' },
    languages = make_langagues_block(),
  },
}

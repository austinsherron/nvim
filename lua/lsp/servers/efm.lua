
local LOGGER = GetLogger('EFM')

local FORMATTERS = {
  lua = 'stylua',
}

local LINTERS = {
  lua = 'luacheck',
}

local function get_efm_config(type, component)
  return require(fmt('efmls-configs.%ss.%s', type, component))
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

  for lang, name in pairs(components) do
    local config = configs[lang] or {}

    Array.append(config, get_efm_config(type, name))
    configs[lang] = config

    log(type, lang, name, config)
  end

  return configs
end


local function make_langagues_block()
  local configs = make_component_config(FORMATTERS, 'formatter')
  return make_component_config(LINTERS, 'linter', configs)
end

return {
  init_options = { documentFormatting = true },
  settings     = {
    rootMarkers = { '.git/' },
    languages   = make_langagues_block(),
  },
}


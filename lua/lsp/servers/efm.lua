local LOGGER = GetLogger 'EFM'

local FORMATTERS = {
  lua = { 'stylua' },
  python = { 'black', 'isort' },
}

local LINTERS = {
  lua = { 'luacheck' },
  python = { 'pylint' },
}

local function get_efm_config(type, component)
  return Safe.require(fmt('efmls-configs.%ss.%s', type, component))
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

      Array.append(config, get_efm_config(type, name))
      configs[lang] = config

      log(type, lang, name, config)
    end
  end

  return configs
end

local function make_langagues_block()
  local configs = make_component_config(FORMATTERS, 'formatter')
  return make_component_config(LINTERS, 'linter', configs)
end

return {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/' },
    languages = make_langagues_block(),
  },
}

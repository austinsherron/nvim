local Env = require 'toolbox.system.env'
local Lambda = require 'toolbox.functional.lambda'
local Path = require 'toolbox.system.path'
local Shell = require 'toolbox.system.shell'

local enum = require('toolbox.extensions.enum').enum

local SERVERS_PATH = Env.nvim_root_pub() .. '/lua/lsp/servers'

local FILETYPE_ALIAS = { terraform = 'tf' }

--- Models contexts in which components are used.
---
---@enum ComponentContext
local ComponentContext = enum({
  CONFIG = 'config',
  INSTALL = 'install',
})

local function has_context(component)
  return Table.contains_any_key(component, ComponentContext:values())
end

local FORMATTERS = {
  go = { 'gci', 'gofumpt' },
  lua = { 'stylua' },
  python = {
    [ComponentContext.INSTALL] = { 'ruff' },
    [ComponentContext.CONFIG] = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
  },
  -- FIXME: not working the way I want it to
  -- sh = { 'shfmt' },
  -- TODO: no OOB efmls config
  yaml = { 'yamlfmt' },
}

local LINTERS = {
  go = { 'golangci-lint' },
  lua = { 'luacheck' },
  make = { 'checkmake' },
  python = { [ComponentContext.INSTALL] = 'ruff' },
  sh = { 'shellcheck', 'shellharden' },
  tf = { 'tflint' },
  -- yaml = { 'yamllint' },
}

--- Util for checking/listing configured LSP servers, formatters, and linters.
---
---@class LspLibrary
local LspLibrary = {}

---@note: so ComponentContext is publicly exposed
LspLibrary.ComponentContext = ComponentContext

---@return string[]: an array-like table w/ configured lsp servers
function LspLibrary.servers()
  return map(Shell.ls(SERVERS_PATH), Path.trim_extension)
end

local function get_components(components, context)
  local ctx_components = Table.map_items(components, {
    vals = function(c)
      return ternary(has_context(c), c[context], c)
    end,
  })

  if context ~= ComponentContext.INSTALL then
    return ctx_components
  end

  return Stream.new(Table.values(ctx_components)):flatmap(Lambda.IDENTITY):collect()
end

--- Gets the manifest of formatters.
---
---@param context ComponentContext|nil: optional, defaults to CONFIG; the context in which
--- components are being used (i.e.: installation or config)
---@return { [string]: string[] }|string[]: a map of languages to formatters, or an array
--- of formatter names, depending on the value of context
function LspLibrary.formatters(context)
  context = context or ComponentContext.CONFIG
  return get_components(FORMATTERS, context)
end

--- Checks if library contains a lang specific formatter.
---
---@param lang string: the language to check
---@return boolean: true if library contains a lang specific formatter, false otherwise
function LspLibrary.has_formatter(lang)
  lang = FILETYPE_ALIAS[lang] or lang
  return FORMATTERS[lang] ~= nil
end

--- Gets the manifest of linters.
---
---@param context ComponentContext|nil: optional, defaults to CONFIG; the context in which
--- components are being used (i.e.: installation or config)
---@return { [string]: string[] }|string[]: a map of languages to linters, or an array
--- of linter names, depending on the value of context
function LspLibrary.linters(context)
  context = context or ComponentContext.CONFIG
  return get_components(LINTERS, context)
end

--- Checks if library contains a lang specific linter.
---
---@param lang string: the language to check
---@return boolean: true if library contains a lang specific linter, false otherwise
function LspLibrary.has_linter(lang)
  lang = FILETYPE_ALIAS[lang] or lang
  return LINTERS[lang] ~= nil
end

return LspLibrary

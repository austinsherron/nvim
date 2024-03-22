local Env = require 'toolbox.system.env'
local Lambda = require 'toolbox.functional.lambda'
local Path = require 'toolbox.system.path'
local Shell = require 'toolbox.system.shell'

local SERVERS_PATH = Env.nvim_root_pub() .. '/lua/lsp/servers'

local FILETYPE_ALIAS = { terraform = 'tf' }

local FORMATTERS = {
  go = { 'gci', 'gofumpt' },
  lua = { 'stylua' },
  python = { 'black', 'isort' },
  -- FIXME: not working the way I want it to
  -- sh = { 'shfmt' },
  -- TODO: no OOB efmls config
  yaml = { 'yamlfmt' },
}

local LINTERS = {
  go = { 'golangci-lint' },
  lua = { 'luacheck' },
  python = { 'pylint' },
  sh = { 'shellcheck', 'shellharden' },
  tf = { 'tflint' },
  -- yaml = { 'yamllint' },
}

--- Util for checking/listing configured LSP servers, formatters, and linters.
---
---@class LspLibrary
local LspLibrary = {}

---@return string[]: an array-like table w/ configured lsp servers
function LspLibrary.servers()
  return map(Shell.ls(SERVERS_PATH), Path.trim_extension)
end

local function get_components(components, namesonly)
  if namesonly ~= true then
    return components
  end

  return Stream.new(Table.values(components)):flatmap(Lambda.IDENTITY):collect()
end

--- Gets the manifest of formatters.
---
---@param namesonly boolean|nil: optional, defaults to false; if true, returns an array of
--- formatter names instead of a map of languages -> formatters
---@return { [string]: string[] }|string[]: a map of languages to formatters, or an array
--- of formatter names, depending on the value of namesonly
function LspLibrary.formatters(namesonly)
  return get_components(FORMATTERS, namesonly)
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
---@param namesonly boolean|nil: optional, defaults to false; if true, returns an array of
--- linter names instead of a map of languages -> linters
---@return { [string]: string[] }|string[]: a map of languages to linters, or an array
--- of linter names, depending on the value of namesonly
function LspLibrary.linters(namesonly)
  return get_components(LINTERS, namesonly)
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

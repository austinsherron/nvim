local NeoReplKM = require 'keymap.plugins.tools.neorepl'
local Path = require 'utils.api.vim.path'

local HISTORY_PATH = Path.log() .. '/neorepl-history.log'

--- Imports for neorepl to make this a little easier.
local function do_imports()
  Array = require 'toolbox.core.array'
  Bool = require 'toolbox.core.bool'
  Dict = require 'toolbox.core.dict'
  String = require 'toolbox.core.string'
  Table = require 'toolbox.core.table'

  Set = require 'toolbox.extensions.set'
  Stream = require 'toolbox.extensions.stream'

  Map = require 'toolbox.utils.map'
  Optional = require 'toolbox.utils.optional'
end

local function on_init(bufnr)
  do_imports()
  NeoReplKM.bind_on_init(bufnr)
end

--- Contain utilities for configuring the neorepl plugin.
---
---@class NeoRepl
local NeoRepl = {}

---@return table: a table that contains configuration values for the neorepl plugin
function NeoRepl.opts()
  return {
    histfile = HISTORY_PATH,
    histmax = 1000,
    indent = 4,
    lang = 'lua',
    on_init = on_init,
  }
end

return NeoRepl

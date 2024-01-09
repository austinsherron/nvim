local Hydra = require 'plugins.extensions.interface.hydra'
local KeyMapper = require 'utils.core.mapper'
local LoggerType = require 'toolbox.log.type'
local Logs = require 'utils.api.logs'

local HintFmttr = Hydra.HintFormatter

local ViewMode = require('utils.api.vim.buffer').ViewMode

local KM = KeyMapper.new({ desc_prefix = 'logs: ', nowait = true })

-- interactions ----------------------------------------------------------------

local function make_type_binding(type, viewmode)
  return {
    type.binding .. viewmode.binding,
    function()
      Logs.open({ type = type, viewmode = viewmode })
    end,
    { desc = fmt('open %s logs in %s', String.upper(type.key), viewmode.label) },
  }
end

local function make_type_bindings(type)
  return Stream.new(ViewMode:values())
    :map(function(v)
      return make_type_binding(type, v)
    end)
    :collect()
end

local function get_logger_types()
  return Array.sorted(Table.values(LoggerType.all()), {
    key = function(t)
      return t.i
    end,
  })
end

local function make_log_bindings()
  local bindings = {}
  local types = get_logger_types()

  for _, type in pairs(types) do
    Array.appendall(bindings, make_type_bindings(type))
  end

  Array.appendall(bindings, {
    Hydra.Constants.VERTICAL_BREAK,
    Hydra.Constants.VERTICAL_BREAK,
    Hydra.Constants.VERTICAL_BREAK,
    { 'x', Logs.close, { desc = 'close logs' } },
  })

  return bindings
end

KM:with_hydra({ name = '🗒 Logs', body = '<leader>l' })
  :with({ hint = HintFmttr.middle_3(), color = 'blue' })
  :bind(make_log_bindings())
  :done()

local path   = require 'lib.lua.system.path'
local import = require 'lib.lua.utils.import'
local onerr  = require 'utils.errorhandling.onerr'


-- require recursively all lua files in this dir
import.require_for_init(
  path.script_path(),
  'keymap',
  onerr.notify
)


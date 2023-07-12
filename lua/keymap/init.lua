local import = require 'lib.lua.utils.import'
local onerr = require 'nvim.lua.utils.onerr'
local path = require 'lib.lua.system.path'


-- require recursively all lua files in this dir
import.require_for_init(
  path.script_path(),
  'nvim.lua.keymap',
  onerr.notify
)


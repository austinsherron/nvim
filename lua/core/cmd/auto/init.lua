local Path   = require 'lib.lua.system.path'
local Import = require 'lib.lua.utils.import'
local OnErr  = require 'utils.error.onerr'


-- recursively require all lua files in this dir
Import.require_for_init(
  Path.script_path(),
  'core.cmd.auto',
  OnErr.notify
)


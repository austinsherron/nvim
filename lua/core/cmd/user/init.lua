local Path   = require 'lib.lua.system.path'
local Import = require 'lib.lua.utils.import'


-- recursively require all lua files in this dir
Import.require_for_init(
  Path.script_path(),
  'core.cmd.user',
  OnErr.notify
)


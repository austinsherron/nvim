local Path   = require 'toolbox.system.path'
local Import = require 'toolbox.utils.import'


-- recursively require all user autocmds that should load before plugins
Import.require_for_init(
  Path.script_path(),
  'core.cmd.auto.before',
  OnErr.notify
)


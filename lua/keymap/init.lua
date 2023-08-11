local Path   = require 'toolbox.system.path'
local Import = require 'toolbox.utils.import'


-- recursively require all lua files in this dir
Import.require_for_init(
  Path.script_path(),
  'keymap',
  OnErr.notify
)


local Import = require 'toolbox.utils.import'
local Path = require 'toolbox.system.path'

-- recursively require all user autocmds that should load before plugins
Import.require_for_init(Path.script_path(), 'core.cmd.auto.before', OnErr.notify)

local Import = require 'toolbox.utils.import'
local Path = require 'toolbox.system.path'

GetLogger('USERCMD'):info 'Creating usercmds'

-- recursively require all lua files in this dir
Import.require_for_init(Path.script_path(), 'core.cmd.user', OnErr.notify)

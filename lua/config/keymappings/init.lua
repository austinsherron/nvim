local import = require 'lib.lua.utils.import'
local path = require 'lib.lua.system.path'


import.require_for_init(path.script_path(), 'nvim.lua.config.keymappings')


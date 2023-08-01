-- import globals: logger, notification service, etc. before doing anything else
require 'utils.globals'

local Safe = require 'utils.error.safe'


-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
Safe.require 'core.bootstrap'

-- plugins ---------------------------------------------------------------------

-- note: settings/keymap has dependencies on plugins, so load them first
Safe.require(
  'utils.plugins.pluginmanager',
  function(m) m.init('plugins') end
)

-- commands --------------------------------------------------------------------

Safe.require 'core.cmd.user'
Safe.require 'core.cmd.auto'

-- keymap ----------------------------------------------------------------------

Safe.require 'keymap'

-- settings --------------------------------------------------------------------

Safe.require 'core.settings'

-- appearance ------------------------------------------------------------------

Safe.require 'core.appearance'


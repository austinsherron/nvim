
-- globals ---------------------------------------------------------------------

-- import globals before doing anything else
require 'utils.globals'

-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
Safe.require 'core.bootstrap'

-- plugins ---------------------------------------------------------------------

-- settings/keymap have dependencies on plugins, so load them first
Safe.require(
  'utils.plugins.pluginmanager',
  function(m) m.init('plugins') end
)

-- commands --------------------------------------------------------------------

-- keymap has dependencies on commands
Safe.require 'core.cmd.user'
Safe.require 'core.cmd.auto'

-- keymap ----------------------------------------------------------------------

Safe.require 'keymap'

-- settings --------------------------------------------------------------------

Safe.require 'core.settings'

-- appearance ------------------------------------------------------------------

Safe.require 'core.appearance'


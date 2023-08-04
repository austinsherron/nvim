
-- globals ---------------------------------------------------------------------

-- import globals before doing anything else
require 'lua.utils.globals'

-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
Safe.require 'lua.core.bootstrap'

-- plugins ---------------------------------------------------------------------

-- settings/keymap have dependencies on plugins, so load them first
Safe.require(
  'utils.plugins.pluginmanager',
  function(m) m.init('plugins') end
)

-- commands --------------------------------------------------------------------

-- keymap has dependencies on commands
Safe.require 'lua.core.cmd.user'
Safe.require 'lua.core.cmd.auto'

-- keymap ----------------------------------------------------------------------

Safe.require 'lua.keymap'

-- settings --------------------------------------------------------------------

Safe.require 'lua.core.settings'

-- appearance ------------------------------------------------------------------

Safe.require 'lua.core.appearance'


--- initialize the plugin manager w/ all known plugin specs
Safe:require('utils.plugins.pluginmanager', function(m)
  m.init 'plugins.spec'
end)

local Safe = require 'utils.error.safe'


Safe.require('utils.session', function(s) s.setup({ name = { strategy = 'repository' }}) end)


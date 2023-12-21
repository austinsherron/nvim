local KeyMapper  = require 'utils.core.mapper'
local Session    = require 'utils.api.session'


local KM = KeyMapper.new()

-- sessions (persisted) --------------------------------------------------------

KM:with({ desc_prefix = 'sessions: ' })
  :bind({
    { '<leader>ss', Session.save,         { desc = 'save'            }},
    { '<leader>sl', Session.load_last,    { desc = 'load last'       }},
    { '<leader>sr', Session.load_for_cwd, { desc = 'restore for cwd' }},
}):done()


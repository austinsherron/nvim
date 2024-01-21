local Interaction = require 'utils.api.vim.interaction'
local KeyMapper = require 'utils.core.mapper'

local HintFmttr = require('plugins.extensions.interface.hydra').HintFormatter

local window = Lazy.require 'nvim-window' ---@module 'nvim-window'

local KM = KeyMapper.new({ nowait = true })

-- window ----------------------------------------------------------------------

KM:bind_one("'j", window.pick, { desc = 'jump to window' })

-- zoxide ----------------------------------------------------------------------

local function make_zd_fn(cmd, scope, fuzzy)
  return function()
    local fuzzystr = ternary(fuzzy == true, ' (Fuzzy)', '')
    local prompt = fmt('%s %s%s', scope, 'ZD', fuzzystr)
    local query = Interaction.input(prompt)

    if query ~= nil then
      vim.api.nvim_command(cmd)
    end
  end
end

KM:with_hydra({ name = '🎯📂 Zoxide', body = '<leader>zd' })
  :with({ hint = HintFmttr.middle_right_2(), color = 'blue' })
  :bind({
    { 'w', make_zd_fn(':Lz', 'Window'), { desc = 'Window ZD' } },
    { 'fw', make_zd_fn(':Lzi', 'Window', true), { desc = 'Window ZD (Fuzzy)' } },
    { 't', make_zd_fn(':Tz', 'Tab'), { desc = 'Tab ZD' } },
    { 'ft', make_zd_fn(':Tzi', 'Tab', true), { desc = 'Tab ZD (Fuzzy)' } },
    { 'g', make_zd_fn(':Z', 'Global'), { desc = 'Global ZD' } },
    { 'fg', make_zd_fn(':Zi', 'Global', true), { desc = 'Global ZD (Fuzzy)' } },
  })
  :done()

local Builtins = require 'telescope.builtin'
local KeyMapper = require 'utils.core.mapper'
local Project = require 'plugins.extensions.workspace.project'
local Search = require 'plugins.extensions.search'
local Session = require 'plugins.extensions.workspace.session'

local HintFmttr = require('plugins.extensions.interface.hydra').HintFormatter

local Pickers = Search.Telescope.Pickers
local TreeSearch = Search.Telescope.TreeSearch

local KM = KeyMapper.new({
  desc_prefix = 'telescope: ',
  nowait = true,
})

-- find ------------------------------------------------------------------------

local function make_tscope_cmd(cmd, raw)
  return function()
    cmd = ternary(raw == true, cmd, 'Telescope ' .. cmd)
    Safe.call(vim.api.nvim_command, {}, cmd)
  end
end

KM:with_hydra({ name = '🔭 Telescope', body = '<leader>f' })
  :with({ hint = HintFmttr.bottom_3(), color = 'teal', esc = true })
  :bind({
    { 'a', Builtins.builtin, { desc = 'search telescope built-ins' } },
    { 'b', Builtins.buffers, { desc = 'search buffers' } },
    { 'C', Builtins.colorscheme, { desc = 'search colorschemes' } },
    { 'd', Builtins.diagnostics, { desc = 'search diagnostics' } },
    { 'e', make_tscope_cmd 'emoji', { desc = 'search emojis' } },
    { 'F', TreeSearch.contextual_find_all_files, { desc = 'search all files (hidden, etc.)' } },
    { 'f', Builtins.find_files, { desc = 'search files' } },
    { 'gc', Builtins.git_bcommits, { desc = 'search git commits' } },
    { 'gs', Builtins.git_stash, { desc = 'search git stashes' } },
    { 'h', Builtins.help_tags, { desc = 'search help tags' } },
    { 'H', make_tscope_cmd 'undo', { desc = 'search undo history' } },
    { 'm', Builtins.man_pages, { desc = 'search man pages' } },
    { 'N', Pickers.search_packages, { desc = 'search plugin files' } },
    { 'n', make_tscope_cmd 'notify', { desc = 'search notification history' } },
    { 'p', Project.picker, { desc = 'search projects' } },
    { 'r', make_tscope_cmd 'frecency', { desc = 'search "frecent"' } },
    { 's', Session.picker, { desc = 'search sessions' } },
    { 'T', Builtins.treesitter, { desc = 'search treesitter symbols' } },
    { 't', make_tscope_cmd('TodoTelescope', true), { desc = 'search todo comments' } },
    { 'u', Builtins.lsp_references, { desc = 'find usages' } },
    { 'w', Builtins.live_grep, { desc = 'find words' } },
    { 'y', make_tscope_cmd 'yaml_schema', { desc = 'find yaml schemas' } },
    { 'z', make_tscope_cmd 'zoxide list', { desc = 'find zoxide dirs' } },
  })
  :done({ purge = 'current' })

-- remaps ----------------------------------------------------------------------

---@note: group this key binding to w/ telescope instead of w/ other spell bindings in core
KM:bind_one('<leader>ds', Builtins.spell_suggest, { desc = 'spelling suggestions' })

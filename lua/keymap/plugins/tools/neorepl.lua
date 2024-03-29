local Editor = require 'utils.api.vim.editor'
local KeyMapper = require 'utils.core.mapper'
local View = require 'utils.api.vim.view'

local function close()
  View.close({ filetype = 'neorepl' })
end

local KM = KeyMapper.new({ desc_prefix = 'neorepl: ', nowait = true })

-- interactions ----------------------------------------------------------------

local function repl_cmd(view_mode)
  view_mode = view_mode or Editor.window_aware_split().key
  return fmt(':Repl %s<CR>', view_mode)
end

KM:bind({
  { '<leader>ro', repl_cmd(), { desc = 'open in split' } },
  { '<leader>rf', repl_cmd 'e', { desc = 'open' } },
  { '<leader>rh', repl_cmd 'vsplit', { desc = 'open in split' } },
  { '<leader>rv', repl_cmd 'split', { desc = 'open in vsplit' } },
  { '<leader>rx', close, { desc = 'close' } },
}):done()

-- on_init ---------------------------------------------------------------------

--- Contains functions for configuring key bindings for the neorepl plugin.
---
---@class NeoRepl
local NeoRepl = {}

--- Function that's called when neorepl "attaches" to a buffer. Calls keymapping
--- functions.
---
---@param bufnr integer: the id of the repl buffer (to which key bindings are local)
function NeoRepl.bind_on_init(bufnr)
  KM:with({ buffer = bufnr })
    :bind({
      { '<CR>', '<Plug>(neorepl-eval-line)', { desc = 'evaluate line' }, { 'n', 'i' } },
      { '<M-;>', '<Plug>(neorepl-break-line)', { desc = 'break line' }, { 'i' } },
      {
        '<BS>',
        '<Plug>(neorepl-backspace)',
        { desc = 'backspace (+line breaks)' },
        { 'i' },
      },
      {
        '<Up>',
        '<Plug>(neorepl-hist-prev)',
        { desc = 'get previous cmd(s)' },
        { 'n', 'i' },
      },
      {
        '<Down>',
        '<Plug>(neorepl-hist-next)',
        { desc = 'get next cmd(s)' },
        { 'n', 'i' },
      },
      -- TODO
      -- { '<leader>re', '<Plug>(neorepl-complete)',  { desc = 'function docstring' }},
    })
    :done()
end

return NeoRepl

local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- link visitor ----------------------------------------------------------------

KM:with({ desc_prefix = 'link-visitor: ' })
  :bind({
    { '<leader>ol', ':VisitLinkUnderCursor<CR>', { desc = 'open link under cursor'   }},
    { '<leader>oc', ':VisitLinkNearest<CR>',     { desc = 'open link nearest cursor' }},
    { '<leader>oo', ':VisitLinkInBuffer<CR>',    { desc = 'choose link from buffer'  }},
}):done()

-- neogen ----------------------------------------------------------------------

KM:with({ desc_prefix = 'neogen: ' })
  :bind({
    { '<leader>Df', ':Neogen func<CR>',  { desc = 'function docstring' }},
    { '<leader>Dc', ':Neogen class<CR>', { desc = 'class docstring'    }},
}):done()

-- terminal --------------------------------------------------------------------

-- NOTE: this actually comes from a code plugin, but because all other lspsaga key
--       bindings are in the lsp keymap, this seems like a more appropriate place for this
--       binding
KM:bind_one(
  '<leader>tt',
  ':Lspsaga term_toggle<CR>',
  { desc = 'floating terminal (lspsaga)' }
)


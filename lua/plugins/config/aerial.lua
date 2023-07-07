
local Aer = {}

function Aer.opts()
  return {
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    layout = {
      min_width = 40,
      default_direction = 'prefer_left',
    },
  }
end

return Aer


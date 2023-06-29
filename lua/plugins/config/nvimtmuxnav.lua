
local function opts()
  return {
    disable_when_zoomed = false, -- defaults to false

    keybindings = {
      left  = '<C-h>',
      down  = '<C-j>',
      up    = '<C-k>',
      right = '<C-l>',

      last_active = '<C-\\>',
      next        = '<C-Space>',
    }
  }
end


return {
  opts = opts,
}


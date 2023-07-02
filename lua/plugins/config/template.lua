
local Tmpl = {}

function Tmpl.opts()
  return {
    -- TODO: I should probably see if I can source these from the environment,
    --       or something like that
    name = 'Austin Sherron',
    email = 'dev@pryv.us',
    temp_dir = vim.fn.stdpath('config') .. '/.templates',
  }
end

return Tmpl


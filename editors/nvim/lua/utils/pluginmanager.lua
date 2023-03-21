local function init(plugins)
    local pathbase = vim.fn.stdpath('data') .. '/packages'
    local lazypath = pathbase .. '/lazy.nvim'

    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup(plugins, {
        root = pathbase,
        lockfile = pathbase .. '/.lazy-lockfile.json'
    })
end


return {
    init = init
}

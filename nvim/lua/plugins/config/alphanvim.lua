

local function get_header()
  return {
    " █████   █████          ████  ████                █████████                       █████     ███            ",
    "░░███   ░░███          ░░███ ░░███              ░███░░░░░███                     ░░███     ░░░             ",
    " ░███    ░███   ██████  ░███  ░███   ██████     ░███    ░███  █████ ████  █████  ███████   ████  ████████  ",
    " ░███████████  ███░░███ ░███  ░███  ███░░███    ░███████████ ░░███ ░███  ███░░   ░░███░   ░░███ ░░███░░███ ",
    " ░███░░░░░███ ░███████  ░███  ░███ ░███ ░███    ░███░░░░░███  ░███ ░███ ░░█████   ░███     ░███  ░███ ░███ ",
    " ░███    ░███ ░███░░░   ░███  ░███ ░███ ░███    ░███    ░███  ░███ ░███  ░░░░███  ░███ ███ ░███  ░███ ░███ ",
    " █████   █████░░██████  █████ █████░░██████     █████   █████ ░░████████ ██████   ░░█████  █████ ████ █████",
    "░░░░░   ░░░░░  ░░░░░░  ░░░░░ ░░░░░  ░░░░░░     ░░░░░   ░░░░░   ░░░░░░░░ ░░░░░░     ░░░░░  ░░░░░ ░░░░ ░░░░░ "
  }
end


local function get_buttons()
  return {
    dashboard.button('n', '   > new' , ':ene <BAR> startinsert <CR>'),
    dashboard.button('fp', '  > find file', ':Telescope projects<CR>'),
    dashboard.button('ff', '  > find file', ':Telescope find_files<CR>'),
    dashboard.button('fw', '  > find word', ':Telescope live_grep<CR>'),
    dashboard.button('fr', '  > Recent'   , ':Telescope frecent<CR>'),
    dashboard.button('c', '   > config' , ':e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>'),
    dashboard.button('q', '   > nvm', ':qa<CR>'),
  }
end


-- function alphanvim_opts()
--   return {
--       dashboard.section.header.val = get_header(),
--       dashboard.section.buttons.val = get_buttons(),
--   }
-- end


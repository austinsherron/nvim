
# To-Do Lists

## To-Do

### Plugins/Tooling

- [x] Auto-completion (revisit for advanced configuration)
    - [ ] `cmp-conventionalcommits`
    - [ ] `cmp-dictionary`
- [ ] Auto-correction of diagnostics/linting errors
- [ ] Auto-imports
- [ ] Case Changer (i.e.: CamelCaseEr, snake_case_er, Title-Er, UPPERER, lowerer, etc.er)
- [ ] Code generation (see snippets)
- [ ] Code actions
- [ ] Debugger
- [ ] File templates
- [ ] Opening in existing nvim instances (neovim-remote)
- [ ] Renaming/refactoring
- [ ] Snippets
- [ ] The Line - a stylized indicator that a line is (almost) too long
- [ ] Unit test integrations
    - [x] Ability to run from nvim
    - [ ] Ability to view/act on results
    - [ ] Ability to debug and step through execution

### LSP Support

- [ ] Fish
- [ ] Go
- [ ] Java
- [ ] JavaScript
- [ ] Json
- [ ] K8S Yaml
- [ ] Terraform
- [ ] Toml
- [ ] TypeScript
- [ ] Yaml
- [ ] Zsh

### Tasks

- [ ] I'm not totally happy w/ my tab/buffer management schemes and my non-workflows that haven't really come to be w/ my current tooling
- [ ] Incorporate tabs (and windows?) into workflows (not very concrete)
- [ ] How can I open multiple files at once w/ nvimtree?
- [ ] Change diff/merge view colors to something that makes for better UX
- [ ] Remap available spectre commands: https://github.com/nvim-pack/nvim-spectre
- [ ] Add (relative) line numbers by default to diffview, undotree, spectre, etc.
- [ ] Create lualine extensions for diffview, undotree, and spectre
- [ ] Add ability to refactor imports on file move
- [ ] Leap "repeat"/"again" capability, like "n"/"N" in search?
- [ ] Git interactions from nvimtree (partially there w/ stage/unstage)
- [ ] Add LuaSnip custom snippets
- [ ] Enhance styling (i.e.: selective bolding, diff fonts, etc.)
- [ ] Refactor nvim utils to separate repo? (at least those that would be/are useful for plugins as well)
- [ ] Use lsp hooks to plug into lsp, instead of baking dependent code directly into lsp setup
- [ ] Continue comments only in docstrings
- [ ] Automatically add new params to docstrings
- [ ] Add unit tests
- [ ] Add more systematic logging
- [ ] Add more systematic error-handling
- [ ] Change diagnostic symbols to something snazzier
- [ ] Add tracebacks to error logging
- [ ] Add ability to make file "un-executable" from nvim-tree
- [ ] Configure auto-completion support for neorepl
- [ ] Add barbar + session integration so buffers are restored in correct order
- [ ] Integrate scopes.nvim w/ session manager
- [ ] Configure layouts for individual telescope pickers, based on usability, and extensions, to the extent possible
- [ ] Convert user commands to lua apis?
- [ ] Add ability to open spectre in a arbitrary splits, own buffer, tab, modal, etc.

### Fixes

- [ ] Issue upgrading LuaSnip
- [ ] Figure out why barbar diagnostics don't work
- [ ] "Fix plugins extension" (?)
- [ ] Disable cmdline auto-completion for specific commands (ls, for example)
- [ ] Barbar shouldn't reopen non-editable/help buffers (i.e.: nvimtree, diffview, side panel, etc.)
- [ ] Bufresize should ignore certain window types (i.e.: nvimtree, diffview, side panel, etc.)
- [ ] Figure out why neorepl doesn't always seem to have the latest version of code, even when I stop/start nvim (maybe due to my "on_bind" global imports...?)
- [ ] Fix snippet loading
- [ ] Fix statusline crowding in specific utility buffers (i.e.: nvimtree, diffview file tree, probably others)
- [ ] Editorconfig line length constraints aren't being enforced
- [ ] Fix issues w/ duplicate sessions (one w/ branch + one w/o)
- [ ] Fix session save logic that closes non-restorable buffers
- [ ] Figure out why session seem not to save sometimes, or don't save w/ the right cwd

### Ideas

#### Refactor

- [ ] Change parameter position, or otherwise change parameters
    - [ ] Update docs
    - [ ] Update call sites
- [ ] Make function, method, field, etc public/private/package/protected
    - [ ] For lua, convert function to/from local
- [ ] Easily wrap values in function calls/or arbitrary braces
- [ ] Easily move functions/methods w/in a file
- [ ] Moving files w/ path dependent imports changes imports
- [ ] Change case style (i.e.: CamelCaseEr, snake_case_er, Title-Er, UPPERER, lowerer, etc.er)
- [ ] Auto-fill completed function params
- [ ] Deleting a control structure and automatically reindenting interior code
- [ ] Remove control structure, i.e.: remove loops/if statements/etc, fix indentation/formatting of code contained therein

#### File Create Sub-Menu

Menu in file-explorer (i.e.: nvim-tree) that allows you to choose specific kinds of files/dirs to create. Can include custom types as well as templates. Some examples:

- [ ] New lang specific file
  - [ ] lua
  - [ ] python
  - [ ] shell (i.e.: bash)
- [ ] New lang specific folder structure
  - [ ] Python project (i.e.: w/ project.toml)
  - [ ] Python module (i.e.: w/ __init__.py)
- [ ] Create missing function/method/var, etc.

#### Buffer/Tab Interaction Feature

- [ ] Pretty status/interaction menu consisting of
    - [ ] Tabs
    - [ ] Buffers, grouped by tabs if possible
- [ ] Interactions include
    - [ ] Navigating to tab
    - [ ] Navigating to buffer
    - [ ] Opening/creating tabs
    - [ ] Opening/creating buffers
    - [ ] Closing/deleting tabs
    - [ ] Closing/deleting buffers
    - [ ] Renaming tabs
    - [ ] Moving tabs?
    - [ ] Moving/regrouping buffers?

#### Inspection Menu

Hydra menu w/ that enables contextual inspections, including:

- [ ] Checking cwd
- [ ] Current buffer info
- [ ] Current tab info
- [ ] Current window info
- [ ] If session is recording

#### Log Interactions

- [ ] Update logs opener to make buffer non-modifiable
- [ ] Update logs opener to set custom filetype
- [ ] Add buffer menu that lists logs available for exploration

## Done

### Plugins/Tooling

- [x] Auto-pairs
- [x] Code searching utility (always room for improvement here)
- [x] Code outline (still exploring other options)
- [x] Colorscheme (but always evolving)
- [x] Comments
- [x] Diff viewer (could be better though...)
- [x] Docstring template insertion (explore configuration options)
- [x] Filetree/explorer (not 100% happy, need to look into neo-tree, etc.)
- [x] Find + replace
- [x] Formatting
- [x] Fuzzy-find commands
- [x] General prettiness (😅)
- [x] Git in-file indicators (again, not 100% happy, want to continue exploring)
- [x] Git history interactions (i.e.: file history, git blame, etc.)
- [x] Git state interactions (commit, merge, rebase, cherry-pick, etc.) (lazygit)
- [x] Inline docs/hints
- [x] Linting
- [x] Merge tool (...at least needs further configuration)
- [x] Notifications
- [x] Persistent undo history
- [x] Project manager (still wanna see what other options are out there though)
- [x] Session manager
- [x] Sniprun
- [x] Start screen? (again, wanna explore)
- [x] Status bar (would like to customize it more though) (and investigate extensions)
- [x] Surround
- [x] Syntax checking (for a small set of languages, guts are there at least)
- [x] Tab/buffer bar
- [x] Telescope
- [x] Undo tree (it works, but could look better... I dunno, wanna continue looking/tinkering)

#### Won't Do

- [x] Tag generator, viewer, and associated plugins
    - [x] Generator - gutentags

### LSP Support

- [x] Bash
- [x] Python3
- [x] Lua

### Tasks

- [x] Make gitsigns symbols more obvious (seems to be based on the colorscheme, but enabling numhl seems to have helped)
- [x] Add ability to optionally suppress notifications when logging w/ nvim logger
- [x] Add ability to parameterize persistence of notifications logged through nvim logger
- [x] Add augroup's to autocmds
- [x] Add leap highlight (more "won't do", as I've adopted folke's "flash.nvim" as my motion plugin of choice)
- [x] Bi-directional leap
- [x] Leap in nvimtree
- [x] Telescope picker for package dir (i.e.: plugins)
- [x] Homegrown session manager (got most [much?] of the way there and then figured out how to make session manager plugin do what I want it to [i.e.: session per dir, more or less])
- [x] Customize titles in contextual telescope extension search
- [x] Better nvim init error handling (unclear if it actually works, but it's there-ish)
- [x] Notifications/modals/confirmation menus on nvim init error
- [x] Logger should write to nvim application logs
- [x] Update nvim alias to include writing to logs (didn't do exactly this, but logs are being written and it's as configurable as it needs to be at this point)
- [x] Refactor KeyMapper to use state so as to avoid duplication "options" functions, etc.
- [x] Enable spell-checker/grammar helper/etc. (potentially investigate spellchecker plugins, i.e.: spelunker)
- [x] Enable minor auto-reformatting, i.e.: aligning spacing, remove trailing whitespace, automatic newlines + alignment, replacing tabs w/ spaces, etc. (editorconfig got me a lot of the way there, but I can still do better -> neoformat)
- [x] Add ability to close all buffers except "this one" (i.e.: the focused buffer)
- [x] Add ability to copy file contents from nvim-tree
- [x] Copy file content to clipboard from nvimtree (dup)
- [x] Add Lualine support for projects
- [x] Add Lualine support for sessions
- [x] Add ability to make file executable from nvim-tree
- [x] Add override key bindings for nvimtree contextual search (constrained contextual search to nvimtree buffer, updated relevant global key bindings to use builtins instead of contextual search functions)
- [x] Add ability to close neorepl from outside of its buffer
- [x] Hydra menu for interacting w/ log files

### Fixes

- [x] !!! Diagnose and fix Treesitter issues (see fb465783acaa09ac0f8c1ab07eac6e22948f8ea3 for resolution notes)
- [x] Figure out why tabs.lua isn't being read from keymap/, then move from keymap/plugins -> keymap/ (ended up being an issues w/ the way "require paths" were being constructed for recursive calls)
- [x] Fix lua_ls workspace configuration prompt
- [x] Fix leap.nvim repeat functionality (didn't really fix this, but have opted, at least for the moment, to use flash.nvim, instead of leap, as my primary motion plugin)
- [x] DiffviewClose doesn't consistently close all diffview buffers/windows (the issue ended up being a usability problem really: it's possible for multiple diffview menus to open, and it's not always obvious what's happening when sequentially closing them)
- [x] Auto-session has issues saving/restoring "special" (maybe literally?) buffers, i.e.: nvim-tree, undotree (presumably), diffview, etc.... (ended up sticking w/ existing session manager plugin)
- [x] Re-install, or otherwise just fix, nvim-tmux-navigation
- [x] Fix buffer ordering (or fix sequential navigation, i.e.: navigate in visual order)
- [x] Fix "redo" custom mapping repeatability, i.e.: I can't hit leader (`<space>`) once and hit `r` N times to get N redo operations (got rid of mapping altogether)
- [x] Fix "redo" custom mapping wait time
- [x] Migrate nvimtree `view.mappings` to `on_attach`
- [x] nvimtree won't toggle hidden files (can't ever see/interact w/ them)
- [x] Nvim is complaining that the Lua LSP isn't installed (used mason to install)
- [x] Something seems to be wrong w/ treesitter plugin setup (opts is nil?) (I think this has been addressed; will know when next update is pushed)
- [x] Fix gitsigns on_attach (doesn't seem to be getting bound/called)
- [x] Add more words/better dictionaries ("suggest word(s)" action never actually suggests anything) (ended up being a misconfiguration: spell suggest setting shouldn't have been an int)
- [x] Update lua files/packages that export functions to encapsulate them in tables
- [x] Figure out why, even after changing the supposedly relevant vim configs., adding a new line from a comment, above or below the commented line, continues the comment
- [x] Fix issues w/ session mgr not restoring sessions from cwd even though I'm now manually setting it (switched session mgr from neovim-session-mgr to persisted.nvim + added custom session lifecycle mgmt)
- [x] Figure out auto-session <-> lualine integration issues, i.e.: can't import auto-session.lib (or auto-session at all, really) (switched session mgr from neovim-session-mgr to persisted.nvim + added custom session lifecycle mgmt)
- [x] Figure out why restoring sessions often causes barbar errors (switched session mgr from neovim-session-mgr to persisted.nvim + added custom session lifecycle mgmt)
- [x] Check for nvim-surround treesitter dependency; if it has one, add it to TreesitterPlugin and make downstream changes
- [x] Figure out cyclic import issue w/ logging
- [x] Fix aerial markdown issue
- [x] Fix indent-blankline
- [x] Figure out why telescope layout config params seem to not be respected sometimes (as it turns out, this seems to be an issues exclusively for extensions; unfortunately, extensions don't make guarantees about their configuration params, and so may not respect the same layout config options the builtin pickers do)
- [x] Figure out why additional key bindings to packages telescope finder aren't working (they weren't using the telescope api to get the selected value)

#### Won't Do

- [x] Figure out auto-session <-> lualine integration issues, i.e.: can't import auto-session.lib (or auto-session at all, really)
    - [x] I no longer use auto-session (at least for the time being)

### Ideas


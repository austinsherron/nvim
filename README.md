# Neovim

I'm a longtime vim user, recent nvim convert. I'm having a lot of fun (and probably spending too much time 😅) diving into the ecosystem and crafting
my setup. My goal is to move from IntelliJ to an nvim based, "home-baked" IDE. My current big ticket items are:

- [x] Trying to find a file browser that feels right, or that I can hack easily enough to feel natural
- [x] Getting the bare bones pickers there and natural feeling
- [ ] Setting up LSP related functionality, including: auto-completion, assisted refactoring, various "jump-to"/find commands, etc.
- [ ] Tightening up git integration; I've installed [diffview.nvim](https://github.com/sindrets/diffview.nvim) and [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), but I need to further configure them. [Neogit](https://github.com/TimUntersberger/neogit) seems promising, for filling in some functional gaps, so I think I'll install that next
- [ ] Installing and incorporating into my workflows one of the many snippets engines out there. I haven't made much use of snippets in the past, so this will be something a bit new for me.

There are definitely more, but this README, like my nvim journey in general, is a work in progress!

## Plugin Manifest

I organize my plugins into the following categories:

* **Appearance** - Appearance plugins control how nvim looks: colors, icons, textures, menus, etc. These are distinct from interface plugins in that interface elements should be functional (and ideally useful). Appearance is the place for things that provide aesthetic value only.
* **Code** - Code plugins control nvim's ability to understand, generate, and generally interact w/ code.
* **Editor** - Editor plugins control core editor capabilities like commenting, general text manipulation, etc.
* **Git** - Git plugins enable nvim + git interactions/integrations.
* **Interface** - Interface plugins add to, control, or augment interface elements. Interface elements should *do something*, or at least be informational, as opposed to being purely aesthetic.
* **Motion** - Motion plugins control on-screen (as opposed to file-system) movement.
* **Navigation** - Navigation plugins control (file) system (as opposed to on-screen) movement.
* **Search** - Search plugins make it easier to find things.
* **Tools** - Tools plugins add misc. functionality to nvim; they add *explicitly new* functionality to nvim, as opposed to changing something about the way its core functions work. Tools here don't fit into any other categories.

## Structure

```
.
├── lua
│   ├── config
│   │   ├── keymappings
│   │   │   └── plugins
│   │   └── lsp
│   │       └── servers
│   ├── plugins
│   │   ├── config
│   │   │   └── cmp
│   │   └── extensions
│   └── utils
└── templates

```

## To-Do Lists

### Plugins/Tooling

- [x] Auto-completion (revisit for advanced configuration)
- [ ] Auto-correction (?)
- [ ] Auto-imports
- [ ] Auto-pairs
- [ ] Code generation (see snippets)
- [x] Code searching utility (always room for improvement here)
- [x] Colorscheme (but always evolving)
- [x] Comments
- [ ] Debugger
- [x] Diff viewer (could be better though...)
- [x] Docstring template insertion (explore configuration options)
- [ ] File templates
- [x] Filetree/explorer (not 100% happy, need to look into neo-tree, etc.)
- [x] Find+Replace
- [ ] Fuzzy-find commands
- [ ] Formatting
- [ ] General prettiness (😅)
- [x] Git in-file indicators (again, not 100% happy, want to continue exploring)
- [ ] Git history interactions (i.e.: file history, git blame, etc.)
- [ ] Git state interactions (commit, merge, rebase, cherry-pick, etc.) (neogit)
- [ ] Inline docs/hints
- [x] Merge tool (...at least needs further configuration)
- [ ] Notifications
- [ ] Opening in existing nvim instances (neovim-remote)
- [x] Persistent undo history
- [x] Project manager (still wanna see what other options are out there though)
- [ ] Renaming/refactoring
- [x] Session manager
- [ ] Snippets
- [x] Start screen? (again, wanna explore)
- [x] Status bar (would like to customize it more though) (and investigate extensions)
- [x] Surround
- [x] Syntax checking (for a small set of languages, guts are there at least)
- [x] Tab/buffer bar
- [x] Telescope
- [ ] The Line - a stylized indicator that a line is (almost) too long
- [x] Undo tree (it works, but could look better... I dunno, wanna continue looking/tinkering)

### LSP Support

- [x] Python3
- [x] Lua
- [ ] Go
- [ ] Java
- [x] Bash
- [ ] Zsh
- [ ] Fish
- [ ] JavaScript
- [ ] TypeScript
- [ ] K8S Yaml
- [ ] Terraform

### Tasks

- [x] Enable spell-checker/grammar helper/etc. (potentially investigate spellchecker plugins, i.e.: spelunker)
- [ ] Enable minor auto-reformatting, i.e.: aligning spacing, remove trailing whitespace, automatic newlines + alignment, replacing tabs w/ spaces, etc.
- [ ] I'm not totally happy w/ my tab/buffer management schemes and my non-workflows that haven't really come to be w/ my current tooling (i.e.: it'd be nice to have some visual labels of which buffer is which, and a quick way to jump to that buffer
- [x] Add ability to close all buffers except "this one" (i.e.: the focused buffer)
- [ ] (Not very concrete) Incorporate tabs (and windows?) into workflows
- [ ] How can I open multiple files w/ nvimtree?
- [ ] Change diff/merge view colors to something that makes for better UX
- [ ] Make gitsigns symbols more obvious
- [ ] Remap available spectre commands: https://github.com/nvim-pack/nvim-spectre
- [ ] Add (relative) line numbers by default to diffview, undotree, spectre, etc.

### Fixes

- [x] Re-install, or otherwise just fix, nvim-tmux-navigation
- [x] Fix buffer ordering (or fix sequential navigation, i.e.: navigate in visual order)
- [ ] Fix "redo" custom mapping repeatability, i.e.: I can't hit leader (`<space>`) once and hit `r` N times to get N redo operations
- [x] Fix "redo" custom mapping wait time
- [x] Migrate nvimtree `view.mappings` to `on_attach`
- [x] nvimtree won't toggle hidden files (can't ever see/interact w/ them)
- [x] Nvim is complaining that the Lua LSP isn't installed (used mason to install)
- [x] Something seems to be wrong w/ treesitter plugin setup (opts is nil?) (I think this has been addressed; will know when next update is pushed)
- [x] Fix gitsigns on_attach (doesn't seem to be getting bound/called)
- [ ] Add more words/better dictionaries ("suggest word(s)" action never actually suggests anything)
- [ ] Update lua files/packages that export functions to encapsulate them in tables
- [ ] Figure out why, even after changing the supposedly relevant vim configs., why from a comment, above or below the commented line, continues the comment
- [ ] Issue upgrading LuaSnip


# Neovim

I'm a longtime vim user, recent nvim convert. I'm having a lot of fun (and probably spending too much time 😅) diving into the ecosystem and crafting
my setup. My goal is to move from IntelliJ to an nvim based, "home-baked" IDE. My current big ticket items are:

* Trying to find a file browser that feels right, or that I can hack easily enough to feel natural
  * Still on nvim-tree after trying out nnn and not really digging it
  * neo-tree seems promising, I just haven't gotten there yet
* Getting the bare bones pickers there and natural feeling

There are definitely more, but this README, like my nvim journey in general, is a work in progress!

## To-Do Lists

### Plugins/Tooling

- [ ] Auto-completion/correction
- [ ] Auto-imports
- [ ] Code generations (see snippets)
- [x] Code searching utility (always room for improvement here)
- [x] Colorscheme (but always evolving)
- [x] Comments
- [ ] Debugger
- [x] Diff viewer (could be better though...)
- [ ] File templates
- [x] Filetree/explorer (not 100% happy, need to look into neo-tree, etc.)
- [ ] Find+Replace
- [ ] Fuzzy-find commands
- [ ] Formatting
- [ ] General prettiness (😅)
- [x] Git in-file indicators (again, not 100% happy, want to continue exploring)
- [ ] Git history interactions (i.e.: file history, git blame, etc.)
- [ ] Git state interactions (commit, merge, rebase, cherry-pick, etc.)
- [ ] Git sidebar changes
- [ ] Inline docs/hints
- [ ] Merge tool
- [ ] Notifications
- [ ] Opening in existing nvim instances (neovim-remote)
- [x] Persistent undo history
- [x] Project manager (still wanna see what other options are out there though)
- [ ] Renaming/refactoring
- [x] Session manager
- [ ] Snippets
- [x] Start screen? (again, wanna explore)
- [x] Status bar (would like to customize it more though)
- [x] Surround
- [ ] Syntax checking
- [x] Tab/buffer bar
- [x] Telescope
- [x] Undo tree (it works, but could look better... I dunno, wanna continue looking/tinkering)

### Tasks

- [x] Enable spell-checker/grammar helper/etc. (potentially investigate
      spellchecker plugins, i.e.: spelunker)
- [ ] Add more words/better dictionaries ("suggest word(s)" action never actually
      suggests anything)
- [ ] Enable minor auto-reformatting, i.e.: aligning spacing, remove trailing
      whitespace, automatic newlines + alignment, replacing tabs w/ spaces, etc.
- [ ] I'm not totally happy w/ my tab/buffer management schemes and my
      non-workflows that haven't really come to be w/ my current tooling (i.e.:
      it'd be nice to have some visual labels of which buffer is which, and a
      quick way to jump to that buffer
- [x] Add ability to close all buffers except "this one" (i.e.: the focused buffer)
- [ ] (Not very concrete) Incorporate tabs (and windows?) into workflows
- [ ] How can I open multiple files w/ nvimtree?

### Fixes

- [ ] Re-install, or otherwise just fix, nvim-tmux-navigation
- [x] Fix buffer ordering (or fix sequential navigation, i.e.: navigate in visual
      order)
- [ ] Fix "redo" custom mapping repeatability, i.e.: I can't hit leader (`<space>`)
      once and hit `r` N times to get N redo operations
- [x] Migrate nvimtree `view.mappings` to `on_attach`
- [x] nvimtree won't toggle hidden files (can't ever see/interact w/ them)
- [x] Nvim is complaining that the Lua LSP isn't installed (used mason to install)
- [ ] Something seems to be wrong w/ treesitter plugin setup (opts is nil?)


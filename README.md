# Neovim config

## Context

I'm a VSCode user, but like the modal and keyboard centric code editing experience that NeoVim provides. So I am aiming to produce a NeoVim configuration that offers similar IDE-like features as VSCode, but not looking to produce a VSCode clone in NeoVim.

## Principles

The main principles and technologies for my config are these:
- Prefer native behaviour over plugins. Don't reinvent the wheel and try to actually learn VIM, not learn how an assorted bunch of plugins work. Prefer plugins which _extend_ native VIM commands over plugins which _replace_ them.
- Aim to have a fully modal UX. Prefer modals over things like drawers and panels which are always visible. Only implement panels/drawers when the content in the panel is directly related to the active file buffer.  - Accommodate working with split windows to view multiple files and/or terminals at once. Avoid tabs, they just complicate things.
- Aim to have a Lua based config. Prefer Lua based plugins over VimScript based ones.
- Use Treesitter for syntax highlighting. For plugins that show file previews, prefer plugins that leverage Treesitter.
- For searching/navigating prefer Telescope (plugins). Telescope is nice and having a consistent UI is convenient.


## Software development use cases and their implementations

### Project navigation

This describes how to find and open projects in NeoVim. In practice, for me, a "project" and a "GitHub repo" tend to boil down to the same thing.

#### Goals:
- Easily switch projects
- Easily see which project I'm currently in
- Pick up where I left off
- Use one OS Window per project (using the Kitty terminal emulator)

#### Implementation:
- [x] Solution based on `auto-session` and `session-lens` (Telescope plugin)
- [x] Configured `auto-session` to be enabled for project folders only. To achieve this I wrote a custom function that scans my `~/apps` folder, where all my projects live and I add a custom entry for my NeoVim config repo, which lives in my home directory.
- [x] Configured `auto-session` to update the Kitty OS window title to the project name. This ensures I can see which project I am working on.
- [x] The `session-lens` plugin allows me to switch to another project easily. The old session will be closed, so effectively I am opening a new project in the existing OS window.
- [x] Opening a project in a new window involve opening a new terminal window, starting NeoVim, then using session lens to select the project. It could be good to automatically open session lens when there is no session and NeoVim is started from the default dir. And perhaps also to open the Telescope file picker after that. 
- [x] Starting a new project isn't really covered explicitly, but that will usually involve `cd`ing into a dir, cloning a repo, etc. anyway, so I don't think that then issuing the `v` command to open NeoVim, which will then start a its whole auto-session workflow will work well enough.

### File navigation and management

#### Goals:
- Create/edit/delete files and directories in the current project
- Find a file in the current project
- Show this file in the currently active window
- This could mean making an already opened buffer the active on, but also opening a file

#### Use cases and their implementations

- [ ] Create/edit/delete files and directories and visually inspect the project directory structure: use both native Vim functionality and `nvim-tree.lua` (setup in vinegar style, see [docs section 4.1](https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt))
- [x] Navigate to a file by name: Telescope `builtin.git_files`
- [ ] Navigate to a related file, i.e. from a component to a CSS module or a test file: `jumpwire.nvim`
- [x] List open files (buffers) and select one: Telescope `builtin.buffers`

### Code navigation

#### Goals
- Identify a specific section of code
- Jump to it
- This includes both navigation within the currently active buffer and also to project-wide navigation

#### Use cases and their implementations

- [x] Fuzzy find a specific string and jump to it: Telescope `builtin.live_grep`
- [ ] Go to a variable (type) definition: Telescope `builtin.lsp_definitions` & `builtin.lsp_type_definitions`
- [ ] Go to a variable reference: Telescope `builtin.lsp_references`
- [x] Jump to anywhere within a single document: `hop.nvim`
- [x] Learn and use builtin Vim motions for in-file-navigation

### Code editing

#### Goals
- Edit code
- Write comments and comment out code
- Auto close tags
- Save file(s)

#### Use cases and their implementations

- [x] Writing code: Rely built-in Vim commands
- [x] Get suggestions while typing (IntelliSense): use `nvim-cmp` and add various sources that provide suggestions (LSP, buffer, snippets, etc).
- [x] Format code (automatically): the actual formatting should not be done by a text editor, but be a completely independent platform-agnostic process. For example for JavaScript I rely exclusively on Prettier and via `null-ls` NeoVim is configured to use that.
- [ ] Find and replace within a file: apart from Vim's built in functionality, use `vim-subversive` with `vim-abolish` and `vim-yoink`
- [ ] Project-wide find and replace: using Telescope `builtin.live_grep` and sending the results to quick-fix lists seems to be the Vim way to go. Another possible solution would be to use 
- [ ] Refactor code: use `refactoring.nvim`
- [x] Saving a file: use built-in Vim commands, and also implement keybindings to save while in insert mode 
- [x] Use `Comment.nvim` for comments
- [ ] Use `vim-matchup`, `nvim-autopairs` and `windwp/nvim-ts-autotag` for automatically closing tags

### Code validation

#### Goals
- Identify code issues easily
- Run tests
- View diagnostics
- View available code actions

#### Use cases and their implementations

- [x] Lint code: similar to formatting, linting should be independent of the editor. For JavaScript I use ESLint and the TypeScript language server and setup LSP bindings. The editor is responsible for showing visual cues in the editor, such as squiggly lines and signs in the gutter.
- [ ] Run test and view results: run commands in terminal. This is a long running process and the output needs to be in view. This can done with `toggleterm.nvim` [custom terminal](https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage).
- [ ] Use `trouble.nvim` for showing diagnostics
- [ ] Use Telescope to show code actions from `vim.lsp.buf.code_action()`. `telescope-ui-select.nvim` seems the way to do this. `glepnir/lspsaga.nvim` should be removed.
- [ ] Rename symbol, project wide
- [ ] Fix/sort imports

### Version Control / Git

- [x] Use `fugitive.vim` for running git commands
- [ ] Use `lazygit` in a `toggleterm.nvim` [custom terminal](https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage) for a Git UI
- [ ] Use `gitsigns.nvim` for displaying info in the gutter, showing file/line blame, staging hunks
- [ ] Use Telescope to list various things:
    - `builtin.git_commits`
    - `builtin.git_branches`
    - `builtin.git_status`
    - `builtin.git_stash`

### Window management
- [x] Easily use some preconfigured layouts
- [ ] Currently using `vim-window-resize-easy` for incrementally resizing windows. This isn't working great since you _can_ repeat the resizing keys, but you _can't_ actually see the updated window size until after the timeout. A nicer solution would be to implement a Vim submode for window management as described in [this article](https://ddrscott.github.io/blog/2016/making-a-window-submode/). Another option would be to use `hydra.nvim` to make this.
- [ ] Use `toggleterm.nvim` for show a floating terminal, a terminal in a drawer or sidebar

## Long term ideas
- Perhaps setting up a proper debugger would be nice. But firstly I hardly ever use this in VSCode, and secondly the tooling that looks most interesting to use looks a bit immature:
    - `nvim-dap`
    - `nvim-dap-ui`
    - `nvim-dap-virtual-text`
- Also, `nvim-neotest` might something nice to use alongside the nvim-dap setup so we can visually inspect (Jest) tests etc.
- Loosely related, this new package called `mason.nvim` seems to be a great idea: one single tool to manage "external processes" like LSP servers and debuggers.
- If the Git workflow above isn't great, `git-messenger.vim` looks good too.
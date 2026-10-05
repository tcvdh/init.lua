# Neovim config

Lua config for Neovim **0.12+** using [lazy.nvim](https://github.com/folke/lazy.nvim).
Leader key is `<Space>`.

## Install on a new machine

```sh
git clone https://github.com/tcvdh/init.lua.git ~/.config/nvim
nvim
```

First launch bootstraps lazy.nvim and installs every plugin. Mason then installs the language
servers and tools, and treesitter compiles parsers as you open files. Wait for it to finish
(watch `:Lazy` and `:Mason`), then restart nvim.

One manual step: run `:Copilot auth` to sign in to GitHub Copilot.

### System dependencies (install yourself)

| Needed for | Packages |
|---|---|
| Neovim itself | `neovim` 0.12 or newer |
| Plugin install, mason downloads | `git`, `curl`, `tar`, `unzip`, `gzip` |
| Compiling treesitter parsers | a C compiler (`gcc` or `clang`) |
| Grep (`<leader>ps`) | `ripgrep` |
| Icons | a [Nerd Font](https://www.nerdfonts.com/) set in your terminal |
| Mason-installed Python tools (`basedpyright`) and npm tools (`prettier`, `tsgo`) | `python`, `node` + `npm` |
| Lazygit (`<leader>gg`) | `lazygit` |
| Clipboard on Linux | `wl-clipboard` (Wayland) or `xclip` (X11) |

Arch: `sudo pacman -S neovim git curl unzip gcc ripgrep nodejs npm python lazygit wl-clipboard`
macOS: `brew install neovim ripgrep node lazygit` (plus a Nerd Font and Xcode CLT for the compiler)

Optional:
- LaTeX (vimtex): a TeX distribution with `latexmk`, `latexindent`, and a viewer.
  `zathura` on Linux, `sioyek` on macOS (picked automatically in `lazy/vimtex.lua`).
- `fd`: Snacks uses it for file search when present, otherwise falls back to `rg`.
- Rust formatting needs `rustfmt` (`rustup component add rustfmt`).

### Installed automatically by Mason

Language servers (`lazy/lsp.lua`): `lua_ls`, `rust_analyzer`, `clangd`, `asm_lsp`, `tsgo`,
`texlab`, `basedpyright`, `ruff`. Zig (`zls`) is configured but only enabled if you install it.

Tools: `tree-sitter-cli`, `stylua`, `prettier`, `clang-format`.

If something is missing, `:Mason` shows state and `:checkhealth` tells you what is wrong.

## Layout

```
init.lua                    -> require("tcvdh")
lua/tcvdh/
  init.lua                  requires the files below
  set.lua                   options
  remap.lua                 general keymaps
  autocmds.lua              yank highlight, LSP keymaps (set on attach)
  lazy_init.lua             lazy.nvim bootstrap
  lazy/                     one file per plugin (or group)
clang-format-default.yaml   C/C++ fallback style (see below)
.stylua.toml                Lua formatting: 4 spaces, 100 columns
```

## Plugins

| Area | Plugins |
|---|---|
| Core | lazy.nvim, plenary, nvim-web-devicons |
| UI | catppuccin (macchiato), lualine, which-key, fidget, todo-comments, snacks (dashboard, notifier, indent guides) |
| Navigation | snacks picker, oil.nvim, flash.nvim |
| Git | gitsigns, lazygit (via snacks) |
| LSP | nvim-lspconfig, mason, mason-lspconfig, mason-tool-installer, lazydev |
| Completion | blink.cmp, friendly-snippets, copilot.lua (inline ghost text) |
| Formatting | conform.nvim |
| Syntax | nvim-treesitter (`main` branch), treesitter-context, asm-context |
| Editing | vim-sleuth, nvim-autopairs, neotab |
| Languages | vimtex (LaTeX), render-markdown |

## Keymaps

Press `<Space>` and wait: which-key lists everything available.

### Search and files (Snacks, Oil)

| Key | Action |
|---|---|
| `<leader>pf` | Find files in project (includes dotfiles, skips `.git`) |
| `<leader>ps` | Grep text across the project |
| `<leader>pw` | Grep word under cursor (or visual selection) |
| `<leader><leader>` | Open buffers |
| `<leader>sn` | Find files in this nvim config |
| `<leader>pv` | Oil: open file explorer |
| `-` | Oil: open parent directory as an editable buffer (rename by editing, `:w` to apply) |
| `z=` | Spelling suggestions |
| `<leader>gg` | Lazygit |

Search starts from the directory nvim was opened in, so open it at the project root.
In a picker, `<C-q>` sends results to the quickfix list.

### LSP (active only in buffers with a language server)

| Key | Action |
|---|---|
| `gd` | Go to definition (`<C-o>` to jump back) |
| `K` | Hover docs |
| `]d` / `[d` | Next / previous diagnostic |
| `<leader>vd` | Diagnostics for the current line |
| `<leader>vca` | Code actions (normal and visual) |
| `<leader>vrr` | References |
| `<leader>vrn` | Rename symbol |
| `<leader>vws` | Workspace symbols |
| `<C-s>` (insert) | Signature help |
| `<leader>f` | Format buffer (conform, falls back to LSP) |
| `<leader>q` | Diagnostics to location list |

Neovim 0.12 built-ins also work: `grr` references, `gra` code action, `grn` rename, `gri` implementation.

### Completion (blink.cmp)

| Key | Action |
|---|---|
| `<C-Space>` | Open menu / docs |
| `<M-j>` / `<M-k>` | Next / previous item (`<C-n>` / `<C-p>` also work) |
| `<M-Enter>` | Accept (selects the first item if none selected) |
| `<C-e>` | Close menu |
| `<C-k>` | Signature help |

### Copilot (inline suggestions)

| Key | Action |
|---|---|
| `<M-l>` | Accept suggestion |
| `<C-l>` | Accept one line |
| `<Esc>` | Dismiss |

### Jumping with flash.nvim

| Key | Action |
|---|---|
| `s` + chars | Jump: type 1-2 characters, then press the label shown at the target |
| `S` | Select a treesitter block (function, `if`, arguments), works with operators: `dS` |
| `r` (after an operator) | Remote: `yr` + pattern + label yanks there without moving |
| `R` (operator/visual) | Treesitter search |
| `<C-s>` (in `/` search) | Toggle flash labels on search |

`s` replaces the built-in single-character substitute; use `cl` instead.

### Git (gitsigns)

| Key | Action |
|---|---|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (works on a visual selection) |
| `<leader>hS` | Stage buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>tb` | Toggle inline blame |

### General

| Key | Action |
|---|---|
| `J` / `K` (visual) | Move selected lines down / up |
| `<C-h/j/k/l>` | Move between windows |
| `<leader>s` | Substitute the word under cursor across the file |
| `<leader>p` (visual) | Paste without overwriting the register |
| `<leader>d` | Delete without yanking |
| `<C-f>` / `#` (visual) | Search forward / backward for the selection |

Markdown renders inside the buffer automatically; `:RenderMarkdown toggle` turns it off.

## Formatting

`<leader>f` runs conform:

| Filetypes | Formatter |
|---|---|
| c, cpp | `clang-format`. A `.clang-format` in the project (searched upward) wins; otherwise `clang-format-default.yaml` (LLVM, 4 spaces, 100 columns) |
| lua | stylua |
| python | ruff (`ruff_format`) |
| js, ts, tsx, json, yaml | prettier |
| rust | rustfmt |
| tex | latexindent |

## Indentation

Defaults are 4 spaces. `vim-sleuth` detects the real indent from `.editorconfig` or the existing
file contents. Treesitter only does highlighting; indenting uses Vim's built-in indent files
(`cindent` for C/C++).

## Notes

- Treesitter is on the `main` branch because `master` breaks on Neovim 0.12.
- `lazy-lock.json` pins plugin versions. Commit it after updating with `:Lazy update`.
- Text width and color column are both 100; spell check is on for markdown, text, gitcommit, and tex.

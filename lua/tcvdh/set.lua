-- Set space as the leader key for custom mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable Nerd Font features
vim.g.have_nerd_font = true
-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- -- Disable highlighting of search results after search is done
-- vim.opt.hlsearch = false
-- -- Enable incremental search (showing matches as you type)
-- vim.opt.incsearch = true

-- Enable true color support in terminal
vim.opt.termguicolors = true

-- Display a vertical line at column 80 for code formatting guidance
vim.opt.colorcolumn = "80"

-- Enable mouse support in all modes
vim.opt.mouse = "a"
-- Hide the mode indicator (INSERT, VISUAL, etc) since status line shows it
vim.opt.showmode = false

-- Set clipboard to use system clipboard (scheduled to avoid startup issues)
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- Disables line wrapping
vim.opt.wrap = false
-- Enable persistent undo history
vim.opt.undofile = true
-- Make searches case-insensitive by default
vim.opt.ignorecase = true
-- Make searches case-sensitive when uppercase characters are used
vim.opt.smartcase = true
-- Always show the sign column for git markers and diagnostics
vim.opt.signcolumn = "yes"
-- Reduce time to trigger CursorHold event (for faster LSP hover) (250 before)
vim.opt.updatetime = 50
-- Reduce delay for key combinations
vim.opt.timeoutlen = 250

-- Open new vertical splits to the right
vim.opt.splitright = true
-- Open new horizontal splits below
vim.opt.splitbelow = true
-- Show invisible characters
vim.opt.list = true
-- Set how invisible characters are displayed
vim.opt.listchars = "tab:»·,trail:·,nbsp:·"
-- Preview substitutions as you type
vim.opt.inccommand = "split"

-- Highlight the current line
vim.opt.cursorline = true
-- Keep cursor 8 lines from top/bottom of screen when scrolling
vim.opt.scrolloff = 8
-- Prompt for confirmation instead of failing commands
vim.opt.confirm = true

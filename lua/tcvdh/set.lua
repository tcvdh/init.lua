vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local o = vim.opt

o.number = true
o.relativenumber = true
o.cursorline = true
o.scrolloff = 12
o.signcolumn = "yes"
o.colorcolumn = "100"
o.termguicolors = true
o.showmode = false -- lualine shows it
o.list = true
o.listchars = "tab:»·,trail:·,nbsp:·"

-- defaults only; vim-sleuth overrides per file/project (.editorconfig or detected from the file)
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true

o.endofline = true
o.fixendofline = false

o.wrap = true
o.linebreak = true
o.textwidth = 100
o.spelllang = "en_us"

o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

o.mouse = "a"
o.swapfile = false
o.undofile = true
o.confirm = true
o.updatetime = 250 -- idle ms before CursorHold fires and the swap file is written
o.timeoutlen = 300

o.splitright = true
o.splitbelow = true

vim.schedule(function()
    o.clipboard = "unnamedplus" -- deferred: slows startup otherwise
end)

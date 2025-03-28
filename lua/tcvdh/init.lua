require("tcvdh.set")
require("tcvdh.remap")
require("tcvdh.lazy_init")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- set assembly syntax
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.s", "*.S", "*.asm" },
    callback = function()
        vim.bo.filetype = "gas"
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }
        -- Go to the definition of the symbol under cursor
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- Show hover information for the symbol under cursor
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        -- Search for symbols in the current workspace
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- Show diagnostics in a floating window
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        -- Show available code actions
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        -- List all references to the symbol under cursor
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        -- Rename the symbol under cursor
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        -- Display signature help while typing function arguments
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        -- Go to the next diagnostic
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        -- Go to the previous diagnostic
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

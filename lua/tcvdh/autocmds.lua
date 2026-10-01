vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("SpellOnProse", { clear = true }),
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
    callback = function(event)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
        map("n", "<leader>vd", vim.diagnostic.open_float, "Line diagnostics")
        map({ "n", "x" }, "<leader>vca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>vrr", vim.lsp.buf.references, "References")
        map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename")
        map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")
        map("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")
    end,
})

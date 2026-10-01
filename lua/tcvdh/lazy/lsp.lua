return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "saghen/blink.cmp",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        vim.lsp.config("lua_ls", {
            settings = { Lua = { runtime = { version = "LuaJIT" } } },
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
        })

        vim.lsp.config("asm_lsp", {
            filetypes = { "asm", "s", "S" },
            root_markers = { ".git" },
        })

        vim.lsp.config("zls", {
            root_markers = { ".git", "build.zig", "zls.json" },
            settings = {
                zls = { enable_inlay_hints = true, enable_snippets = true, warn_style = true },
            },
        })
        vim.g.zig_fmt_parse_errors = 0
        vim.g.zig_fmt_autosave = 0

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "asm_lsp",
                "ts_ls",
                "texlab",
                "basedpyright",
                "ruff",
            },
            automatic_enable = true,
        })

        require("mason-tool-installer").setup({
            ensure_installed = { "tree-sitter-cli", "stylua", "prettier", "black", "clang-format" },
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
            virtual_text = { prefix = "●", spacing = 4 },
            severity_sort = true,
        })
    end,
}

local default_clang_style = vim.fn.stdpath("config") .. "/clang-format-default.yaml"

return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            python = { "ruff_format" },
            rust = { "rustfmt" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            yaml = { "prettier" },
            tex = { "latexindent" },
        },
        formatters = {
            -- project's .clang-format wins; otherwise use the shared default
            ["clang-format"] = {
                args = function(_, ctx)
                    local project = vim.fs.find({ ".clang-format", "_clang-format" }, {
                        path = ctx.dirname,
                        upward = true,
                    })[1]
                    return {
                        "--assume-filename",
                        ctx.filename,
                        "--style=" .. (project and "file" or "file:" .. default_clang_style),
                    }
                end,
            },
            latexindent = {
                prepend_args = { "-m", "-l", "indentconfig.yaml", "-g", "/dev/null" },
            },
        },
    },
}

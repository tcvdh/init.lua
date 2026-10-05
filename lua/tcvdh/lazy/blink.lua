return {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt fuzzy matcher, no Rust toolchain needed
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        keymap = {
            preset = "default",
            ["<M-j>"] = { "select_next", "fallback" },
            ["<M-k>"] = { "select_prev", "fallback" },
            ["<M-Enter>"] = { "select_and_accept", "fallback" },
        },
        completion = {
            list = { selection = { preselect = false } },
            menu = { border = "rounded" },
            documentation = { auto_show = true, window = { border = "rounded" } },
        },
        signature = { enabled = true, window = { border = "rounded" } },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
}

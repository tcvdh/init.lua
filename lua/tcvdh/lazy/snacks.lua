return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        picker = {},
        explorer = { replace_netrw = false }, -- oil owns directory buffers
        notifier = {},
        input = {},
        indent = {},
        scope = {},
        dashboard = {},
        lazygit = {},
    },
    keys = {
        {
            "<leader>pf",
            function()
                Snacks.picker.files({ hidden = true })
            end,
            desc = "Project: find files",
        },
        {
            "<leader>ps",
            function()
                Snacks.picker.grep({ hidden = true })
            end,
            desc = "Project: grep text",
        },
        {
            "<leader>pw",
            function()
                Snacks.picker.grep_word()
            end,
            mode = { "n", "x" },
            desc = "Project: grep word under cursor",
        },
        {
            "<leader><leader>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Open buffers",
        },
        {
            "<leader>sn",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Search nvim config",
        },
        { "<leader>pv", "<cmd>Oil<cr>", desc = "File explorer (oil)" },
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "z=",
            function()
                Snacks.picker.spelling()
            end,
            desc = "Spelling suggestions",
        },
    },
}

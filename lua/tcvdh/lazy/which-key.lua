return {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
        delay = 0,
        spec = {
            { "<leader>p", group = "Project" },
            { "<leader>v", group = "LSP" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Git hunks" },
        },
    },
}

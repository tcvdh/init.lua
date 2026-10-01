return {
    "stevearc/oil.nvim",
    lazy = false, -- must load at startup to take over directory buffers
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "-", "<cmd>Oil<cr>", desc = "Parent directory (oil)" } },
    opts = {
        default_file_explorer = true,
        view_options = { show_hidden = true },
    },
}

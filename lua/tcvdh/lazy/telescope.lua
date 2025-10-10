return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
        require('telescope').setup({
            defaults = {
                initial_mode = "normal",
            },
            extensions = {
                ["ui-select"] = {
                    require('telescope.themes').get_dropdown(),
                }
            }
        })
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [f]ind" })
        vim.keymap.set("n", "<leader><leader>", function()
            builtin.buffers({
                sort_lastused = true,
            })
        end , { desc = "[ ] Find existing buffers" })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })
    end,
}

return {
    -- Highlight, edit, and navigate code
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
                "asm"
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = { "ruby", "latex" },
            },
            indent = { enable = true, disable = { "ruby" } },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require('treesitter-context').setup {
                enable = true,
            }
        end
    }
}

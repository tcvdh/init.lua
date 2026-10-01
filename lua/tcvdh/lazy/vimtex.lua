return {
    "lervag/vimtex",
    lazy = false,

    init = function()
        if vim.fn.has("mac") == 1 then
            -- macOS configuration
            vim.g.vimtex_view_method = "sioyek"
        else
            -- Linux configuration (Zathura for Arch/Hyprland)
            vim.g.vimtex_view_method = "zathura"
        end
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "tex",
            callback = function()
                vim.opt_local.spell = true
                vim.opt_local.spelllang = "en_us"
            end,
        })
    end,
}

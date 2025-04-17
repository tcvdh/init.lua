return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_method = "sioyek"
    if vim.fn.has('mac') == 1 then
      -- macOS configuration
      vim.g.vimtex_view_method = "sioyek"
    else
      -- Linux configuration (default)
      vim.g.vimtex_view_method = "zathura"
    end
  end
}

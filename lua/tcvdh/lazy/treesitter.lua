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
                additional_vim_regex_highlighting = { "ruby" },
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

            vim.api.nvim_create_augroup("CustomAsmContext", { clear = true })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter", "WinEnter" }, {
                pattern = { "*.S", "*.s", "*.asm" },
                group = "CustomAsmContext",
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    if vim.bo[bufnr].filetype ~= "asm" then
                        -- Cleanup floating window if we leave asm file
                        if vim.b.custom_asm_ctx_win and vim.api.nvim_win_is_valid(vim.b.custom_asm_ctx_win) then
                            vim.api.nvim_win_close(vim.b.custom_asm_ctx_win, true)
                            vim.b.custom_asm_ctx_win = nil
                        end
                        return
                    end

                    -- Use the parser directly to find labels
                    local parser = vim.treesitter.get_parser(bufnr, "asm")
                    local tree = parser:parse()[1]
                    local root = tree:root()

                    -- Get the query
                    local query = vim.treesitter.query.parse("asm", "((label) @label)")

                    -- Get cursor position
                    local cursor_pos = vim.api.nvim_win_get_cursor(0)
                    local cursor_row = cursor_pos[1] - 1

                    -- Find the closest label above cursor
                    local closest_label = nil
                    local closest_row = -1

                    for _, node in query:iter_captures(root, bufnr, 0, cursor_row) do
                        local start_row = node:range()
                        if start_row <= cursor_row and start_row > closest_row then
                            closest_label = node
                            closest_row = start_row
                        end
                    end

                    -- Display context if found
                    if closest_label then
                        local start_row, start_col, end_row, end_col = closest_label:range()
                        local label_text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

                        -- Remove existing context window
                        if vim.b.custom_asm_ctx_win and vim.api.nvim_win_is_valid(vim.b.custom_asm_ctx_win) then
                            vim.api.nvim_win_close(vim.b.custom_asm_ctx_win, true)
                        end

                        -- Create new context window
                        local win_width = vim.api.nvim_get_option("columns")
                        local context_buf = vim.api.nvim_create_buf(false, true)
                        vim.api.nvim_buf_set_lines(context_buf, 0, -1, false, { table.concat(label_text, "") })
                        vim.api.nvim_buf_set_option(context_buf, "modified", false)

                        local win_opts = {
                            relative = "editor",
                            row = 0,
                            col = 0,
                            width = win_width,
                            height = 1,
                            focusable = false,
                            style = "minimal",
                            border = "none"
                        }

                        vim.b.custom_asm_ctx_win = vim.api.nvim_open_win(context_buf, false, win_opts)

                        -- Style it like treesitter-context would
                        vim.api.nvim_win_set_option(vim.b.custom_asm_ctx_win, "winhighlight", "Normal:TreesitterContext")
                    elseif vim.b.custom_asm_ctx_win and vim.api.nvim_win_is_valid(vim.b.custom_asm_ctx_win) then
                        -- No label found, close the window
                        vim.api.nvim_win_close(vim.b.custom_asm_ctx_win, true)
                        vim.b.custom_asm_ctx_win = nil
                    end
                end
            })
        end
    }
}

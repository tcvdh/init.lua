-- main branch: master's query predicates are broken on nvim 0.12 (markdown hover/injections)
-- needs the tree-sitter CLI (`:MasonInstall tree-sitter-cli`)
local no_highlight = { tex = true, latex = true }

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.install({
                "bash",
                "c",
                "cpp",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
                "asm",
            })

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
                callback = function(ev)
                    local ft = ev.match
                    local lang = vim.treesitter.language.get_lang(ft)
                    if not lang or no_highlight[ft] then
                        return
                    end
                    local function start()
                        pcall(vim.treesitter.start, ev.buf, lang)
                    end
                    if vim.list_contains(ts.get_installed(), lang) then
                        start()
                    elseif vim.list_contains(ts.get_available(), lang) then
                        ts.install(lang):await(function()
                            vim.schedule(function()
                                if vim.api.nvim_buf_is_valid(ev.buf) then
                                    start()
                                end
                            end)
                        end)
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
}

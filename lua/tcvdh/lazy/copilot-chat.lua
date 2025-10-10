return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "zbirenbaum/copilot.lua" },                   -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                            -- Only on MacOS or Linux
    opts = {

    },
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
        local chat = require("CopilotChat")
        chat.setup({
            model = "claude-3.7-sonnet",
            mappings = {
                submit_prompt = {
                    normal = "<C-CR>", -- Ctrl+Enter in normal mode
                    insert = "<C-CR>"  -- Ctrl+Enter in insert mode
                },
                accept_diff = {
                    normal = "<M-l>", -- Alt + l in normal mode
                    insert = "<M-l>"  -- Alt + l in insert mode
                },

            }
        })

        vim.keymap.set({ 'n' }, '<leader>aa', chat.toggle, { desc = 'AI Toggle' })
        vim.keymap.set({ 'v' }, '<leader>aa', chat.open, { desc = 'AI Open' })
        vim.keymap.set({ 'n' }, '<leader>am', chat.select_model, { desc = 'AI Select Model' })
        vim.keymap.set({ 'v' }, '<leader>ae', ":CopilotChatExplain<CR>", { desc = 'AI Explain Code' })
        vim.keymap.set({ 'v' }, '<leader>af', "CopilotChatFix<CR>", { desc = 'AI Fix Code' })
        vim.keymap.set({ 'v' }, '<leader>ad', "CopilotChatDocs<CR>", { desc = 'AI Create Docs' })
    end,
}

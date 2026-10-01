return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        panel = { enabled = false },
        suggestion = {
            auto_trigger = true,
            hide_during_completion = false,
            debounce = 25,
            keymap = {
                accept = "<M-l>",
                accept_word = false,
                accept_line = "<C-l>",
                next = false,
                prev = false,
                dismiss = "<Esc>",
            },
        },
    },
}

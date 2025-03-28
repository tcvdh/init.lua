return {
    dir = '/users/tcvdh/Developer/asm-context.nvim', -- Path to your local plugin directory
    requires = {
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('asm-context').setup({
            max_lines = 4,
        })
    end
}

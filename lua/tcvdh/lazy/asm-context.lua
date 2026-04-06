return {
	"tcvdh/asm-context.nvim",
	requires = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("asm-context").setup({
			max_lines = 4,
		})
	end,
}

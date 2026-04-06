return {
	"scalameta/nvim-metals",
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()

		metals_config.on_attach = function(client, bufnr)
			-- your on_attach function
		end

		return metals_config
	end,
	config = function(self, metals_config)
		vim.lsp.handlers["window/showMessage"] = function(_, result, ctx, _)
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]

			if
				client
				and client.name == "metals"
				and result.type == 3
				and result.message:match("Compiled successfully")
			then
				return
			end

			vim.notify(result.message, lvl, { title = client and client.name or "LSP" })
		end

		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}

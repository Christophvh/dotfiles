return {
	{
		"stevearc/conform.nvim",
		dependencies = { "zapling/mason-conform.nvim" },
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			-- eslint_d: autofixes Prettier never does (unused imports, prefer-const, …)
			-- prettierd: formatting. Use daemons only — plain `prettier`/`eslint` cold-start Node each save.
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "eslint_d", "prettierd" },
				typescriptreact = { "eslint_d", "prettierd" },
				javascript = { "eslint_d", "prettierd" },
				javascriptreact = { "eslint_d", "prettierd" },
				yaml = { "prettierd" },
				json = { "prettierd" },
				html = { "prettierd" },
				scss = { "prettierd" },
				css = { "prettierd" },
				markdown = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
			notify_on_error = true,
		},
		config = function(_, opts)
			require("conform").setup(opts)
			require("mason-conform").setup()
		end,
	},
}

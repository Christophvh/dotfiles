return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- locked compatibility branch; main is an incompatible rewrite
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"graphql",
					"css",
					"dockerfile",
					"git_config",
					"gitignore",
					"json",
					"sql",
					"javascript",
					"typescript",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"tsx",
					"markdown",
					"markdown_inline",
					"regex",
					"yaml",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})

			-- Register tinybird filetype to use sql parser
			vim.treesitter.language.register("sql", "tinybird")
		end,
	},
}

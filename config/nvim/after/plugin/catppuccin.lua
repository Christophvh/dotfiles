require("catppuccin").setup({
	integrations = {
		treesitter = true,
		treesitter_context = true,
		cmp = true,
		gitsigns = true,
		telescope = true,
		dashboard = true,
		neotree = true,
		which_key = false,
		noice = true,
		mini = true,
		navic = { enabled = true, custom_bg = "lualine" },
		indent_blankline = { enabled = true },
		mason = true,
		markdown = true,
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
	},
	flavour = "mocha",
})

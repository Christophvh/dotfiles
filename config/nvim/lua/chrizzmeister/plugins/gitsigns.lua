return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		},
	},
}

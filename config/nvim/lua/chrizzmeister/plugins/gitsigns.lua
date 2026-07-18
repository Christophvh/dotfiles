return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- Blame on every CursorHold is surprisingly expensive; toggle when needed
			current_line_blame = false,
		},
	},
}

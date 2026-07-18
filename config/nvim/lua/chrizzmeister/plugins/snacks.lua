return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			image = { enabled = true },
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			-- Smooth scroll looks nice but adds input latency; keep off for snappiness
			scroll = { enabled = false },
			quickfile = { enabled = true },

			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			picker = { enabled = false },
			notifier = { enabled = false },
			scope = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},
}

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
			"marilari88/neotest-vitest",
		},
		keys = {
			{
				"<leader>tr",
				function()
					local neotest = require("neotest")
					neotest.summary.open()
					neotest.run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tv",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>ts",
				function()
					require("neotest").run.run({ suite = true })
				end,
				desc = "Run test suite",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open()
				end,
				desc = "Open test output",
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output panel",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.fn.getcwd())
				end,
				desc = "Run all tests",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test",
						jestConfigFile = "jest.config.js",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
					require("neotest-vitest"),
				},
				output = {
					enabled = true,
					open_on_run = "short",
				},
				output_panel = {
					enabled = true,
					open = "botright 15new",
				},
			})
		end,
	},
}

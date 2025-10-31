return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- adapter deps
			"nvim-neotest/neotest-jest",
		},

		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test",
						jestConfigFile = "jest.config.js",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})

			vim.keymap.set("n", "<leader>tr", function()
				require("neotest").run.run({
					suite = false,
					testify = true,
				})
			end, { desc = "Debug: Running Nearest Test" })

			vim.keymap.set("n", "<leader>tv", function()
				require("neotest").summary.toggle()
			end, { desc = "Debug: Summary Toggle" })

			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").run.run({
					suite = true,
					testify = true,
				})
			end, { desc = "Debug: Running Test Suite" })

			vim.keymap.set("n", "<leader>to", function()
				require("neotest").output.open()
			end, { desc = "Debug: Open test output" })

			vim.keymap.set("n", "<leader>ta", function()
				require("neotest").run.run(vim.fn.getcwd())
			end, { desc = "Debug: Open test output" })
		end,
	},
}

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.2",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>qf", builtin.quickfix, { desc = "Quickfix" })
			vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Git files" })

			vim.keymap.set("n", "<leader>fw", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end, { desc = "Grep word under cursor" })

			vim.keymap.set("n", "<leader><leader>", function()
				require("telescope").extensions.recent_files.pick()
			end, { desc = "Recent files" })
		end,
	},
	{
		"smartpde/telescope-recent-files",
		lazy = false,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("recent_files")
		end,
	},
}

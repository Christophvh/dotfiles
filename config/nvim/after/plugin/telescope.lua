require("telescope").load_extension("recent_files")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>F", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>qf", builtin.quickfix, {})

-- Only search in git files --
vim.keymap.set("n", "<leader>f", builtin.git_files, {})

vim.keymap.set("n", "<leader>fw", function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)

-- Open recent files
vim.api.nvim_set_keymap(
	"n",
	"<Leader><Leader>",
	[[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
	{ noremap = true, silent = true }
)

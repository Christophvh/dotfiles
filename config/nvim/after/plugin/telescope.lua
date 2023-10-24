local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>F', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- Only search in git files --
vim.keymap.set('n', '<leader>f', builtin.git_files, {})

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({search = vim.fn.input("Grep > ")});

end)



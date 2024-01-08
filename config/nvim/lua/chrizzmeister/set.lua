-- Line number + relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Spaces 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- scroll of the screen
vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Filetypes
vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

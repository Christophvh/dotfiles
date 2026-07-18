-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- always show, prevents layout shift on diagnostics
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.splitright = true -- new vertical splits open on the right
vim.opt.splitbelow = true -- new horizontal splits open below

-- Performance (50ms makes CursorHold/gitsigns/LSP refresh too aggressive)
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- faster which-key / keymap response

-- Undo persistence
vim.opt.undofile = true

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- use system clipboard by default

-- Filetypes (merged into single call)
vim.filetype.add({
	extension = {
		env = "dotenv",
		pipe = "tinybird",
		datasource = "tinybird",
	},
	filename = {
		[".env"] = "dotenv",
		["env"] = "dotenv",
	},
	pattern = {
		["%.env%.[%w_.-]+"] = "dotenv",
	},
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Unused providers (silence health noise; tiny startup win)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

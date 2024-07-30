require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			hide_gitignored = false,
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				".DS_Store",
			},
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--               -- the current file is changed while the tree is open.
			leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
	},
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 2, -- extra padding on left hand side
		},
		modified = {
			symbol = "+",
			highlight = "NeoTreeModified",
		},
        file_size = {
            enabled = false
          },
	},
})

vim.keymap.set("n", "<leader>b", "<Cmd>Neotree toggle<CR>")

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			-- image support
			"folke/snacks.nvim",
		},
		keys = {
			{ "<leader>b", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnostics = true,
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = {
						".DS_Store",
					},
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
			},
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 2,
				},
				modified = {
					symbol = "+",
					highlight = "NeoTreeModified",
				},
				file_size = {
					enabled = false,
				},
				last_modified = {
					enabled = false,
				},
			},
		},
	},
}


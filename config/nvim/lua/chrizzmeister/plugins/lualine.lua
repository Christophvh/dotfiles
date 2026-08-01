return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin-macchiato",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "neo-tree" },
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", cond = function() return vim.fn.winwidth(0) > 100 end },
					{ "diff", cond = function() return vim.fn.winwidth(0) > 120 end },
					{ "diagnostics", cond = function() return vim.fn.winwidth(0) > 100 end },
				},
				lualine_c = { { "filename", path = 1, shorting_target = 20 } },
				lualine_x = {
					{ "encoding", cond = function() return vim.fn.winwidth(0) > 110 end },
					{ "fileformat", cond = function() return vim.fn.winwidth(0) > 110 end },
					{ "filetype", cond = function() return vim.fn.winwidth(0) > 90 end },
				},
				lualine_y = {},
				lualine_z = { { "location", cond = function() return vim.fn.winwidth(0) > 100 end } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = { "progress" },
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		},
	},
}

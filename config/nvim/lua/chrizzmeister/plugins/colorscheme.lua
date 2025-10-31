return {
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd("colorscheme rose-pine-moon")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				integrations = {
					treesitter = true,
					cmp = true,
					gitsigns = true,
					nvim_surround = true,
					telescope = {
						enabled = true,
					},
					neotree = true,
					noice = true,
					mini = {
						enabled = true,
					},
					mason = true,
					native_lsp = {
						enabled = true,
					},
					ts_rainbow = true,
				},
				-- Code syntax styles
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
				lsp_styles = {
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				-- Custom highlight overrides for JSX/TSX and HTML
				custom_highlights = function(colors)
					return {
						["@tag"] = { fg = colors.mauve },
						["@tag.builtin"] = { fg = colors.maroon }, -- e.g. <div>
						["@tag.delimiter"] = { fg = colors.overlay2 }, -- the < and />
						["@tag.attribute"] = { fg = colors.teal },

						["@punctuation.bracket"] = { fg = colors.overlay2 },
						["@operator"] = { fg = colors.sky },

						["@variable.parameter"] = { fg = colors.text },
						["@property"] = { fg = colors.subtext1 },
					}
				end,
			})
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
}

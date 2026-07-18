return {
	"saghen/blink.cmp",
	version = "1.*",
	lazy = false,
	dependencies = { "rafamadriz/friendly-snippets" },

	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			-- Adds () after function-like completions; auto-imports come from LSP resolve
			accept = {
				auto_brackets = { enabled = true },
			},
			list = {
				selection = { preselect = true, auto_insert = false },
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},

	opts_extend = { "sources.default" },
}

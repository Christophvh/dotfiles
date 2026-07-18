return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},

	event = { "BufReadPre", "BufNewFile" },

	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
							},
						},
					},
				},
			},
			eslint = {
				-- Squiggles via LSP; autofix-on-save via eslint_d in conform
				root_dir = function(fname)
					local util = require("lspconfig").util
					return util.root_pattern(
						"eslint.config.js",
						"eslint.config.mjs",
						"eslint.config.cjs",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.yaml",
						".eslintrc.yml",
						".eslintrc.json",
						".eslintrc"
					)(fname)
				end,
				settings = {
					packageManager = "auto",
					format = false, -- prettierd/eslint_d handle this
				},
			},
			-- Keep lspconfig's smart root (tailwind.config.*); do not force .git
			tailwindcss = {
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			},
			dockerls = {},
			jsonls = {},
			-- Default also attaches to typescriptreact — skip that extra Node process
			graphql = {
				filetypes = { "graphql" },
			},
			html = {},
			-- ts_ls intentionally omitted: typescript-tools.nvim handles TS/JS
		},
	},

	config = function(_, opts)
		-- Neovim 0.12+ enables LSP document colors by default (Tailwind bg-red overlays).
		vim.lsp.document_color.enable(false)

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(opts.servers),
			handlers = {
				function(server_name)
					local server_opts = vim.tbl_deep_extend("force", {}, opts.servers[server_name] or {}, {
						capabilities = capabilities,
					})
					require("lspconfig")[server_name].setup(server_opts)
				end,
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
			},
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}

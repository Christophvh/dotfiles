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
					return vim.fs.root(fname, {
						"eslint.config.js",
						"eslint.config.mjs",
						"eslint.config.cjs",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.yaml",
						".eslintrc.yml",
						".eslintrc.json",
						".eslintrc",
					})
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
			vtsls = {
				settings = {
					vtsls = {
						-- Match the project's compiler and configured TypeScript plugins.
						autoUseWorkspaceTsdk = true,
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						-- vtsls follows VS Code's memory setting; 0 is not an uncapped server.
						tsserver = { maxTsServerMemory = 8192 },
						updateImportsOnFileMove = { enabled = "always" },
						suggest = { autoImports = true },
						preferences = {
							includePackageJsonAutoImports = "auto",
						},
						inlayHints = {
							parameterNames = { enabled = "none" },
							parameterTypes = { enabled = false },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = false },
							functionLikeReturnTypes = { enabled = false },
							enumMemberValues = { enabled = false },
						},
					},
				},
			},
		},
	},

	config = function(_, opts)
		-- Neovim 0.12+ enables LSP document colors by default (Tailwind bg-red overlays).
		vim.lsp.document_color.enable(false)

		local capabilities = vim.tbl_deep_extend(
			"force",
			require("blink.cmp").get_lsp_capabilities(),
			require("lsp-file-operations").default_capabilities()
		)

		local vtsls = opts.servers.vtsls
		vtsls.settings.javascript = vim.tbl_deep_extend("force", {}, vtsls.settings.typescript)

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(opts.servers),
			automatic_enable = false,
		})

		for server_name, server_opts in pairs(opts.servers) do
			vim.lsp.config(server_name, vim.tbl_deep_extend("force", {}, server_opts, {
				capabilities = capabilities,
			}))
			vim.lsp.enable(server_name)
		end

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

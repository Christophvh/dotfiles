local cmp_kinds = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = " ",
	Operator = "",
	TypeParameter = "",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"stylua",
				"lua_ls",
				"dockerls",
				"eslint",
				"graphql",
				"html",
				"tailwindcss",
				-- "ts_ls" => use typescript-tools.nvim instead,
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,

				["eslint"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.eslint.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							client.server_capabilities.documentFormattingProvider = true
						end,
						root_dir = function(fname)
							-- Try to find the nearest eslint config (for both ESLint 8 and 9)
							local eslint_config_root = lspconfig.util.root_pattern(
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
							-- If we found an eslint config, use that directory
							if eslint_config_root then
								return eslint_config_root
							end
							-- Otherwise, find the nearest package.json
							return lspconfig.util.root_pattern("package.json")(fname)
						end,
						settings = {
							-- Auto-detect package manager and ESLint version
							packageManager = "auto",
							-- Enable flat config detection for ESLint 9
							experimental = {
								useFlatConfig = nil, -- Let ESLint auto-detect
							},
						},
					})
				end,

				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tailwindcss.setup({
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
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item(cmp_select)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(cmp_select)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			formatting = {
				format = function(_, vim_item)
					if vim.fn.has("unix") then
						vim_item.kind = (cmp_kinds[vim_item.kind] or "")
					end
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Configure diagnostic signs
		local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			-- update_in_insert = true,
			virtual_text = true, -- Shows inline diagnostic messages
			signs = true, -- Shows signs in the sign column
			underline = true, -- Underlines diagnostics
			update_in_insert = false, -- Don't update diagnostics in insert mode
			severity_sort = true, -- Sort diagnostics by severity
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

return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	opts = function()
		return {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
			settings = {
				-- Halves tsserver count per package (no separate diagnostics process)
				separate_diagnostic_server = false,
				-- Cap RAM so one project can't grow without limit (~3GB was your observed size)
				tsserver_max_memory = 3072,
				expose_as_code_action = { "add_missing_imports", "remove_unused_imports", "fix_all" },
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "none",
					includeInlayFunctionParameterTypeHints = false,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = false,
					includeInlayFunctionLikeReturnTypeHints = false,
					includeInlayEnumMemberValueHints = false,
					includeCompletionsForModuleExports = true,
					includeCompletionsWithInsertText = true,
				},
			},
		}
	end,
}

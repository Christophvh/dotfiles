-- Pick ONE AI assistant. Both were active (Copilot LSP via npx + Codeium) and
-- each keeps a long-lived process attached to every buffer.
return {
	-- Copilot disabled: healthcheck showed it attached to 18+ buffers via
	-- `npx @github/copilot-language-server`. Re-enable by uncommenting and
	-- removing/disabling Windsurf below.
	-- {
	-- 	"github/copilot.vim",
	-- 	event = "InsertEnter",
	-- },
	{
		"Exafunction/windsurf.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_cmp_source = false,
				virtual_text = {
					enabled = true,
				},
			})
		end,
	},
}

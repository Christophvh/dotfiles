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
				vim.api.nvim_set_hl(0, "CodeiumSuggestion", { fg = "#808080" })
			end,
	},

	-- CodeCompanion: drive external CLI agents (cursor-cli, opencode) from
	-- Neovim. CLI interaction runs the agent's TUI in a Neovim terminal and
	-- pipes prompts/visual-selections from any buffer. ACP adapters are also
	-- wired for the chat buffer. Leader is `,`, so keybinds use <leader>c*.
	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				acp = {
					opencode = function()
						return require("codecompanion.adapters").extend("opencode")
					end,
					cursor_cli = function()
						return require("codecompanion.adapters").extend("cursor_cli")
					end,
				},
			},
			interactions = {
				chat = { adapter = "opencode" },
				cli = {
					agent = "opencode",
					agents = {
						opencode = {
							cmd = "opencode",
							args = {},
							description = "OpenCode CLI",
							provider = "terminal",
						},
						cursor_cli = {
							cmd = "agent",
							args = {},
							description = "Cursor CLI (agent)",
							provider = "terminal",
						},
					},
					opts = {
						auto_insert = true,
						reload = true,
					},
				},
			},
			display = {
				cli = {
					window = { layout = "vertical", width = 0.4, height = 0.6, opts = { list = false } },
				},
			},
		},
		config = function(self, opts)
			require("codecompanion").setup(opts)
			local cc = require("codecompanion")
			vim.keymap.set({ "n", "v" }, "<leader>cp", function() cc.cli({ prompt = true }) end, { desc = "CodeCompanion: prompt CLI agent" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", function() cc.cli("#{this}", { focus = true }) end, { desc = "CodeCompanion: add context" })
			vim.keymap.set("n", "<leader>cd", function() cc.cli("#{diagnostics} Can you fix these?", { focus = false, submit = true }) end, { desc = "CodeCompanion: fix diagnostics" })
			vim.keymap.set("n", "<leader>ct", function() cc.cli("#{terminal} Sharing the output from the terminal. Can you fix it?", { focus = false, submit = true }) end, { desc = "CodeCompanion: fix terminal output" })
			vim.keymap.set("n", "<leader>cc", function()
				local agents = { "cursor_cli", "opencode" }
				vim.ui.select(agents, { prompt = "CLI agent:" }, function(choice)
					if choice then cc.cli({ agent = choice }) end
				end)
			end, { desc = "CodeCompanion: pick CLI agent" })
		end,
	},
}

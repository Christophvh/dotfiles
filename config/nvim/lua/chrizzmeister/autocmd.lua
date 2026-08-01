local augroup = vim.api.nvim_create_augroup
local ChrizzmeisterGroup = augroup("Chrizzmeister", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Trailing whitespace: skip formatters' filetypes (prettier/stylua handle this)
autocmd({ "BufWritePre" }, {
	group = ChrizzmeisterGroup,
	pattern = "*",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local skip = {
			typescript = true,
			typescriptreact = true,
			javascript = true,
			javascriptreact = true,
			json = true,
			yaml = true,
			html = true,
			css = true,
			scss = true,
			markdown = true,
			lua = true,
		}
		if skip[ft] or vim.bo[args.buf].binary then
			return
		end
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

autocmd("LspAttach", {
	group = ChrizzmeisterGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		local client = vim.lsp.get_client_by_id(e.data.client_id)
		if client and client.name == "vtsls" then
			vim.keymap.set("n", "<leader>gi", function()
				vim.lsp.buf.code_action({
					context = { only = { "quickfix" } },
				})
			end, { buffer = e.buf, desc = "Add import at cursor" })
		end
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vs", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, {
			buffer = e.buf,
			desc = "References",
		})
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<leader>i", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
	end,
})

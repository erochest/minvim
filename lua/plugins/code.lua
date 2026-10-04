
-- TODO: rust clippy
-- TODO: formatting seems awkward

local utils = require("user.utils")

vim.pack.add({
	{ src = utils.gh("nvim-treesitter/nvim-treesitter"), version = "main" },
	utils.gh("neovim/nvim-lspconfig"),
	utils.gh("mason-org/mason.nvim"),
	utils.gh("mason-org/mason-lspconfig.nvim"),
  utils.gh("stevearc/conform.nvim"),
  "https://codeberg.org/mfussenegger/nvim-lint.git",
	utils.gh("nvim-neotest/neotest"),
	utils.gh("danymat/neogen"),
	utils.gh("theprimeagen/refactoring.nvim"),
	utils.gh("mfussenegger/nvim-dap"),
	utils.gh("jay-babu/mason-nvim-dap.nvim"),
	utils.gh("theHamsta/nvim-dap-virtual-text"),
	utils.gh("igorlfs/nvim-dap-view"),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
	callback = function(args)
		local client_id = args.data.client_id
		if not client_id then
			return
		end

		local client = vim.lsp.get_client_by_id(client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client_id, args.buf, {
				autotrigger = true,
			})
		end
	end,
})

-- mason needs to be set up before mason-nvim-dap
require("mason").setup()
require("mason-lspconfig").setup()

vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(vim.lsp.status(), "info", {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

require("conform").setup()
require("neogen").setup({ snippet_engine = "mini" })
require("refactoring").setup()
require("mason-nvim-dap").setup()

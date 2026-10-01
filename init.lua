vim.g.mapleader = " "
vim.opt.shortmess:append("c")
vim.opt.cmdheight = 2
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.timeoutlen = 500
vim.opt.updatetime = 4000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.o.autocomplete = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true

require("vim._core.ui2").enable({})

local gh = function(path)
	return "https://github.com/" .. path
end

vim.pack.add({
	{ src = gh("folke/which-key.nvim") },
})

local wk = require("which-key")
wk.setup()

local nmap = function(description, keys, definition)
	wk.add({
		{ keys, definition, desc = description, mode = "n" },
	})
end

local bnmap = function(buffer, description, keys, definition)
	wk.add({
		{ keys, definition, desc = description, buffer = buffer },
	})
end

vim.pack.add({
	gh("shaunsingh/nord.nvim"),
})

vim.pack.add({
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
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

vim.pack.add({
	{ src = gh("nvim-tree/nvim-web-devicons") },
})

vim.pack.add({
	{ src = gh("ibhagwan/fzf-lua") },
})

require("fzf-lua").setup({ "fzf-native" })

local fzf_vim_config = function()
	require("fzf-lua").files({
		cwd = vim.fn.stdpath("config"),
	})
end

nmap("Global picker", "<leader><space>", "<cmd>FzfLua global<cr>")
nmap("Files", "<leader>f", "<cmd>FzfLua files<cr>")
nmap("Grep picker", "<leader>/", "<cmd>FzfLua grep<cr>")
nmap("Help", "<leader>h", "<cmd>FzfLua helptags<cr>")
nmap("Undo", "<leader>u", "<cmd>FzfLua undotree<cr>")
nmap("Buffers", "<leader>,", "<cmd>FzfLua buffers<cr>")
nmap("Last buffer", "<leader>'", "<cmd>buffer #<cr>")
nmap("Command History", "<leader>:", "<cmd>FzfLua command_history<cr>")
nmap("Notifications", "<leader>n", function()
	Snacks.picker.notifications()
end)
nmap("Spelling Suggestions", "<leader>z", "<cmd>FzfLua spell_suggest<cr>")

wk.add({ "<leader>f", group = "Find" })
nmap("Word", "<leader>fw", "<cmd>FzfLua grep_cword<cr>")
nmap("Lines", "<leader>fl", "<cmd>FzfLua blines<cr>")
nmap("Buffers", "<leader>fb", "<cmd>FzfLua buffers<cr>")
nmap("Recent Files", "<leader>fr", "<cmd>FzfLua oldfiles<cr>")
nmap("Files", "<leader>ff", "<cmd>FzfLua files<cr>")
nmap("Projects", "<leader>fp", function()
	require("persistence").save()
end)
-- Seems like these should be in a differenc submenu?
nmap("Marks", "<leader>fm", "<cmd>FzfLua marks <cr>")
nmap("Jumps", "<leader>fj", "<cmd>FzfLua jumps <cr>")
nmap("Registers", '<leader>f"', "<cmd>FzfLua registers<cr>")
nmap("Searches", "<leader>f/", "<cmd>FzfLua search_history<cr>")
-- and a third?
nmap("Help", "<leader>fh", "<cmd>FzfLua helptags<cr>")
nmap("Commands", "<leader>fc", "<cmd>FzfLua commands<cr>")
nmap("Keymaps", "<leader>fk", "<cmd>FzfLua keymaps<cr>")
nmap("Options", "<leader>fo", "<cmd>FzfLua options<cr>")
nmap("Vim Config", "<leader>fv", fzf_vim_config)
-- TODO: quickfix and location lists?

wk.add({ "<leader>g", group = "Git/JJ" })
nmap("Git Commit picker", "<leader>gc", "<cmd>FzfLua git_commits<cr>")
nmap("Git File History", "<leader>gh", "<cmd>FzfLua git_bcommits<cr>")
nmap("Git Blame", "<leader>gB", "<cmd>FzfLua git_blame<cr>")
nmap("Git Branches", "<leader>gb", "<cmd>FzfLua git_branches<cr>")

wk.add({ "<leader>u", group = "UI" })
nmap("Colorschemes", "<leader>uC", "<cmd>FzfLua colorschemes<cr>")

-- DAP pickers
-- dap_commands	list,run nvim-dap builtin commands
-- dap_configurations	list,run debug configurations
-- dap_breakpoints	list,delete breakpoints
-- dap_variables	active session variables
-- dap_frames	active session jump to frame

vim.pack.add({
	{ src = gh("nvim-lualine/lualine.nvim") },
})

vim.cmd("colorscheme nord")
require("lualine").setup({
	options = { theme = "nord" },
})

vim.pack.add({
	{ src = gh("folke/persistence.nvim") },
})

wk.add({
	{ "<leader>q", group = "Quit" },
})

nmap("Load session", "<leader>qs", function()
	require("persistence").load()
end)
nmap("Select session", "<leader>qS", function()
	require("persistence").select()
end)
nmap("Last session", "<leader>ql", function()
	require("persistence").load({ last = true })
end)
nmap("Stop session saving", "<leader>qd", function()
	require("persistence").stop()
end)

vim.pack.add({
	{ src = gh("ahmedkhalf/project.nvim") },
})

require("project_nvim").setup({
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".jj", "Justfile", ".justfile" },
})

vim.pack.add({
	{ src = gh("jakobwesthoff/project-fzf.nvim") },
})

require("project-fzf").setup()

-- Map <leader>fp to open projects
nmap("Search projects", "<leader>sp", "<cmd>ProjectFzf<CR>")

vim.pack.add({
	{ src = gh("folke/snacks.nvim") },
})

local Snacks = require("snacks")
Snacks.setup({
	bigfile = { enable = true },
	bufdelete = { enable = true },
	dashboard = {
		enable = true,
		preset = {
			-- Used by the `keys` section to show keymaps.
			-- Set your custom keymaps here.
			-- When using a function, the `items` argument are the default keymaps.
			---@type snacks.dashboard.Item[]
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = "\u{eaf7} ", key = "d", desc = "Browse", action = ":oil" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{
					icon = "\u{ec77} ",
					key = "s",
					desc = "Sessions",
					action = function()
						require("persistence").select()
					end,
				},
				{ icon = "\u{f502} ", key = "p", desc = "Projects", action = ":ProjectFzf" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = "\u{e62b} ", key = "m", desc = "Mason", action = ":Mason" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
	debug = { enable = true },
	dim = { enable = true },
	layout = { enable = true },
	notifier = { enable = true },
	rename = { enable = true },
	scratch = { enable = true },
	terminal = { enable = true },
	toggle = { enable = true },
	zen = { enable = true },
})

nmap("Toggle Zen Mode", "<leader>uz", function()
	Snacks.zen()
end)
nmap("Toggle Zoom", "<leader>uZ", function()
	Snacks.zen.zoom()
end)
nmap("Toggle Scratch Buffer", "<leader>.", function()
	Snacks.scratch()
end)
nmap("Select Scratch Buffer", "<leader>S", function()
	Snacks.scratch.select()
end)

wk.add({ "<leader>b", group = "Buffer" })
nmap("Delete Buffer", "<leader>bd", function()
	Snacks.bufdelete()
end)
nmap("Rename File", "<leader>cR", function()
	Snacks.rename.rename_file()
end)
nmap("Dismiss All Notifications", "<leader>un", function()
	Snacks.notifier.hide()
end)
nmap("Toggle Terminal", "<c-/>", function()
	Snacks.terminal()
end)
nmap("which_key_ignore", "<c-_>", function()
	Snacks.terminal()
end)

vim.pack.add({
	gh("nvim-mini/mini.ai"),
	gh("nvim-mini/mini.pairs"),
	gh("nvim-mini/mini.snippets"),
	gh("rafamadriz/friendly-snippets"),
	gh("nvim-mini/mini.surround"),
	gh("nvim-mini/mini.jump2d"),
})
require("mini.ai").setup()
require("mini.pairs").setup()

local mini_snippets = require("mini.snippets")
local gen_loader = mini_snippets.gen_loader
mini_snippets.setup({
	snippets = {
		gen_loader.from_lang(),
	},
})

local snippets_group = vim.api.nvim_create_augroup("MiniSnippetsLSP", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = snippets_group,
	pattern = "*",
	callback = function()
		-- Only start if mini.snippets is installed and not already running for this buffer
		local ok, mini_snippets = pcall(require, "mini.snippets")
		if ok then
			mini_snippets.start_lsp_server()
		end
	end,
})

require("mini.surround").setup()
require("mini.jump2d").setup()

vim.pack.add({
	gh("stevearc/oil.nvim"),
})
require("oil").setup()
nmap("File Explorer", "<leader>e", "<cmd>Oil<cr>")

vim.pack.add({
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mason-org/mason.nvim") },
})

require("mason").setup()
nmap("Mason", "<leader>M", "<cmd>Mason<cr>")

wk.add({
	{ "<leader>c", group = "Code" },
	{ "gr", group = "References" },
	{ "ga", group = "Calls" },
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local fzf = require("fzf-lua")

		bnmap(ev.buffer, "Definitions", "gd", fzf.lsp_definitions)
		bnmap(ev.buffer, "Declarations", "gD", fzf.lsp_declarations)
		bnmap(ev.buffer, "Type definition", "gy", fzf.lsp_typedefs)

		bnmap(ev.buffer, "References", "grr", fzf.lsp_references)
		bnmap(ev.buffer, "Implementations", "gri", fzf.lsp_implementations)

		bnmap(ev.buffer, "Calls Incoming", "gai", fzf.lsp_references)
		bnmap(ev.buffer, "Calls Outgoing", "gao", fzf.lsp_implementations)

		bnmap(ev.buffer, "Symbols", "<leader>cs", fzf.lsp_document_symbols)
		bnmap(ev.buffer, "Workspace Symbols", "<leader>cw", fzf.lsp_live_workspace_symbols)

		bnmap(ev.buffer, "Buffer Diagnostics", "<space>cx", fzf.diagnostics_document)
		bnmap(ev.buffer, "Workspace Diagnostics", "<leader>cX", fzf.diagnostics_workspace)

		bnmap(ev.buffer, "Hover", "K", vim.lsp.buf.hover)
	end,
})

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

vim.pack.add({ gh("lewis6991/gitsigns.nvim") })
require("gitsigns").setup()

-- TODO: buffer tabs

-- TODO: nvim-dap

-- TODO: browse from CWD
-- TODO: editor config
-- TODO: window- and buffer-navigation keymaps
-- TODO: border around LSP hover window
-- TODO: border around which-key window
-- TODO: lsp auto-enable
-- TODO: omnisharp or other dotnet plugin
-- TODO: function and keybinding to update packages
-- TODO: neotest
-- TODO: edgy

-- Path to your local configuration file
local local_config = vim.fn.stdpath("config") .. "/lua/local.lua"

-- Check if the local file exists before loading it
if vim.fn.filereadable(local_config) == 1 then
	require("local")
end

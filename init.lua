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

vim.pack.add({ gh("nvim-lua/plenary.nvim") })

vim.pack.add({
	{ src = gh("folke/which-key.nvim") },
})

local wk = require("which-key")
wk.setup({
	preset = "modern",
})

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
nmap("Files", "<leader>F", "<cmd>FzfLua files<cr>")
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

wk.add({ "<leader>C", group = "Config" })
nmap("Vim Config", "<leader>Cv", fzf_vim_config)
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
nmap("Find project", "<leader>fp", "<cmd>ProjectFzf<CR>")

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
				{ icon = "\u{eaf7} ", key = "d", desc = "Browse", action = ":Oil" },
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
	{ src = gh("mason-org/mason-lspconfig.nvim") },
})

require("mason").setup()
require("mason-lspconfig").setup()
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

vim.pack.add({
	{ src = gh("folke/neoconf.nvim") },
})
require("neoconf").setup()

nmap("Show local/global JSON config files", "<leader>CC", "<cmd>Neoconf<cr>")
nmap("Show local JSON config files", "<leader>Cl", "<cmd>Neoconf local<cr>")
nmap("Show global JSON config files", "<leader>Cg", "<cmd>Neoconf global<cr>")
nmap("Show merged config", "<leader>Cs", "<cmd>Neoconf show<cr>")
nmap("Show merged LSP config", "<leader>CL", "<cmd>Neoconf lsp<cr>")

vim.pack.add({ gh("stevearc/conform.nvim") })
require("conform").setup()

vim.pack.add({ gh("lewis6991/gitsigns.nvim") })
require("gitsigns").setup()

vim.pack.add({ gh("akinsho/bufferline.nvim") })
require("bufferline").setup()

vim.pack.add({ "https://codeberg.org/mfussenegger/nvim-lint.git" })
nmap("Lint", "<leader>cL", function()
	require("lint").try_lint()
end)

vim.pack.add({ gh("folke/trouble.nvim") })
require("trouble")
wk.add({ "<leader>x", group = "Debug" })
nmap("Diagnostics (Trouble)", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
nmap("Buffer Diagnostics (Trouble)", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
nmap("Symbols (Trouble)", "<leader>cS", "<cmd>Trouble symbols toggle focus=false<cr>")
nmap("LSP definitions ... (Trouble)", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
nmap("Location List (Trouble)", "<leader>xL", "<cmd>Trouble loclist toggle<cr>")
nmap("Quickfix List (Trouble)", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>")

local fzf_config = require("fzf-lua.config")
local trouble_actions = require("trouble.sources.fzf").actions
fzf_config.defaults.actions.files["ctrl-t"] = trouble_actions.open

vim.pack.add({ gh("folke/todo-comments.nvim") })
require("todo-comments").setup()

nmap("Next todo comment", "]t", function()
	require("todo-comments").jump_next()
end)
nmap("Previous todo comment", "[t", function()
	require("todo-comments").jump_prev()
end)
nmap("Find TODOs", "<leader>ft", "<cmd>TodoFzfLua<cr>")

vim.pack.add({ gh("jceb/jiejie.nvim") })
vim.g.jiejie_config = {
	default_view = 1,
	log_revisions = 10,
}
nmap("JJ log", "<leader>gl", "<cmd>JJ log<cr>")

-- Following along from https://tamerlan.dev/setting-up-a-testing-environment-in-neovim/
vim.pack.add({
	gh("nvim-neotest/nvim-nio"),
	-- gh("nvim-lua/plenary.nvim"),
	gh("antoinemadec/FixCursorHold.nvim"),
	-- gh("nvim-treesitter/nvim-treesitter"),
	-- gh("nvim-neotest/neotest-jest"),
	gh("nvim-neotest/neotest"),
})

local neotest = require("neotest")
wk.add({ "<leader>t", group = "Test" })
nmap("Run nearest test", "<leader>tr", function()
	neotest.run.run()
end)
nmap("Run current file", "<leader>tf", function()
	neotest.run.run(vim.fn.epand("%"))
end)
nmap("Run all tests", "<leader>ta", function()
	neotest.run.run({ suite = true })
end)
nmap("Debug nearest test", "<leader>td", function()
	neotest.run.run({ suite = false, strategy = "dap" })
end)
nmap("Stop test", "<leader>ts", function()
	neotest.run.stop()
end)
nmap("Attach to nearest test", "<leader>tn", function()
	neotest.run.attach()
end)
nmap("Show test output", "<leader>to", function()
	neotest.output.open()
end)
nmap("Toggle output panel", "<leader>tp", function()
	neotest.output_panel.toggle()
end)
nmap("Toggle summary", "<leader>tv", function()
	neotest.summary.toggle()
end)

nmap("Next buffer", "L", "<cmd>bnext<cr>")
nmap("Previous buffer", "H", "<cmd>bprevious<cr>")
nmap("Focus pane right", "<c-l>", "<c-w>l")
nmap("Focus pane left", "<c-h>", "<c-w>h")
nmap("Focus pane up", "<c-k>", "<c-w>k")
nmap("Focus pane down", "<c-j>", "<c-w>j")

vim.pack.add({
	{ src = gh("saghen/blink.lib") },
	{ src = gh("saghen/blink.cmp") },
	{ src = gh("danymat/neogen") },
})

require("neogen").setup({ snippet_engine = "mini" })
nmap("Generate annotations", "<leader>cg", "<cmd>Neogen<cr>")

vim.pack.add({
	{ src = gh("stevearc/aerial.nvim") },
})
require("aerial").setup({
	on_attach = function(bufnr)
		bnmap(bufnr, "Previous Aerial", "{", "<cmd>AerialPrev<cr>")
		bnmap(bufnr, "Next Aerial", "}", "<cmd>AerialPrev<cr>")
	end,
})
nmap("Toggle Aerial", "<leader>a", "<cmd>AerialToggle!<cr>")

vim.pack.add({
	{ src = gh("monaqa/dial.nvim") },
})

local dial_map = require("dial.map")
nmap("Increment", "<c-a>", function()
	dial_map.manipulate("increment", "normal")
end)
nmap("Increment", "g<c-a>", function()
	dial_map.manipulate("increment", "gnormal")
end)
nmap("Decrement", "<c-x>", function()
	dial_map.manipulate("decrement", "normal")
end)
nmap("Decrement", "g<c-x>", function()
	dial_map.manipulate("decrement", "gnormal")
end)

vim.pack.add({
	-- `async.nvim` is only required for Neovim 0.12. If you are using Neovim 0.13, you don't need it
	"https://github.com/lewis6991/async.nvim",
	"https://github.com/theprimeagen/refactoring.nvim",
})
require("refactoring").setup()
local keymap = vim.keymap

wk.add({
	{ "<leader>r", "Refactoring" },
	{ "<leader>p", "Print Refactor" },
})
keymap.set({ "n", "x" }, "<leader>re", function()
	return require("refactoring").extract_func()
end, { desc = "Extract Function", expr = true })
-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>ree", function()
	return require("refactoring").extract_func() .. "_"
end, { desc = "Extract Function (line)", expr = true })

keymap.set({ "n", "x" }, "<leader>rE", function()
	return require("refactoring").extract_func_to_file()
end, { desc = "Extract Function To File", expr = true })

keymap.set({ "n", "x" }, "<leader>rv", function()
	return require("refactoring").extract_var()
end, { desc = "Extract Variable", expr = true })

-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>rvv", function()
	return require("refactoring").extract_var() .. "_"
end, { desc = "Extract Variable (line)", expr = true })

keymap.set({ "n", "x" }, "<leader>ri", function()
	return require("refactoring").inline_var()
end, { desc = "Inline Variable", expr = true })
keymap.set({ "n", "x" }, "<leader>rI", function()
	return require("refactoring").inline_func()
end, { desc = "Inline function", expr = true })

keymap.set({ "n", "x" }, "<leader>rs", function()
	return require("refactoring").select_refactor()
end, { desc = "Select refactor" })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
keymap.set("n", "<leader>pv", function()
	return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
end, { desc = "Debug print var below", expr = true })
keymap.set("x", "<leader>pv", function()
	return require("refactoring.debug").print_var({ output_location = "below" })
end, { desc = "Debug print var below", expr = true })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
keymap.set("n", "<leader>pV", function()
	return require("refactoring.debug").print_var({ output_location = "above" }) .. "iw"
end, { desc = "Debug print var above", expr = true })
keymap.set("x", "<leader>pV", function()
	return require("refactoring.debug").print_var({ output_location = "above" })
end, { desc = "Debug print var above", expr = true })

keymap.set({ "x", "n" }, "<leader>pe", function()
	return require("refactoring.debug").print_exp({ output_location = "below" })
end, { desc = "Debug print exp below", expr = true })
-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>pee", function()
	return require("refactoring.debug").print_exp({ output_location = "below" }) .. "_"
end, { desc = "Debug print exp below", expr = true })

keymap.set({ "x", "n" }, "<leader>pE", function()
	return require("refactoring.debug").print_exp({ output_location = "above" })
end, { desc = "Debug print exp above", expr = true })
-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>pEE", function()
	return require("refactoring.debug").print_exp({ output_location = "above" }) .. "_"
end, { desc = "Debug print exp above", expr = true })

keymap.set("n", "<leader>pP", function()
	return require("refactoring.debug").print_loc({ output_location = "above" })
end, { desc = "Debug print location", expr = true })
keymap.set("n", "<leader>pp", function()
	return require("refactoring.debug").print_loc({ output_location = "below" })
end, { desc = "Debug print location", expr = true })

keymap.set({ "x", "n" }, "<leader>pc", function()
	-- `ag` is a custom textobject that selects the whole buffer. It's provided by plugins like `mini.ai` (requires manual configuration using `MiniExtra.gen_ai_spec.buffer()`).
	-- return require("refactoring.debug").cleanup { restore_view = true } .. "ag"

	-- this keymap doesn't select any textobject by default, so you need to provide one each time you use it.
	return require("refactoring.debug").cleanup({ restore_view = true })
end, { desc = "Debug print clean", expr = true, remap = true })

-- calling `require("refactoring").setup()` is not required for the plugin to work

keymap.set({ "n", "x" }, "<leader>cr", function()
	-- this keymap doesn't select any textobject by default, so you may need to provide one each time you use it.
	require("refactoring").select_refactor()
end, { desc = "Select refactor" })

vim.pack.add({
	gh("mfussenegger/nvim-dap"),
	gh("jay-babu/mason-nvim-dap.nvim"),
	gh("theHamsta/nvim-dap-virtual-text"),
	gh("igorlfs/nvim-dap-view"),
})

-- mason needs to be set up before mason-nvim-dap
require("mason-nvim-dap").setup()

nmap("Toggle Breakpoint", "<leader>xb", function()
	require("dap").toggle_breakpoint()
end)
nmap("Continue Debugging", "<leader>xc", function()
	require("dap").continue()
end)
nmap("Run to Cursor", "<leader>xC", function()
	require("dap").run_to_cursor()
end)
nmap("Terminate Debugging", "<leader>xT", function()
	require("dap").terminate()
end)

nmap("Toggle View", "<leader>xv")
nmap("View Watch", "<leader>xw")

if vim.loop.os_uname().sysname == "Windows_NT" then
	-- need to use 'nu -l' for terminal
	vim.opt.shell = "nu"
	vim.opt.shellcmdflag = "-c"
	vim.opt.shellredir = "2>&1 | save --raw %s"
	vim.opt.shellpipe = "2>&1 | save --raw %s"
	vim.opt.shellquote = "'"
	vim.opt.shellxquote = ""
	-- if os.execute("command -v pwsh") == 0 then
	--   vim.opt.shell = "pwsh"
	-- else
	--   vim.opt.shell = "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
	-- end

	vim.opt.laststatus = 3
end

-- TODO: border around LSP hover window
-- TODO: function and keybinding to update packages
-- TODO: edgy
-- TODO: break this file up
-- TODO: nvim-navic and nvim-navbuddy

-- Path to your local configuration file
local local_config = vim.fn.stdpath("config") .. "/lua/local.lua"

-- Check if the local file exists before loading it
if vim.fn.filereadable(local_config) == 1 then
	require("local")
end

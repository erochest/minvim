
-- TODO: can probably split this up somehow
-- TODO: ]d (next diagnostic) should pop up the message
-- TODO: [] motions on classes, functions, etc
-- TODO: where is rename symbol (LSP)?

local wk = require("which-key")
local Snacks = require("snacks")
local keymap = vim.keymap
local fzf_config = require("fzf-lua.config")
local trouble_actions = require("trouble.sources.fzf").actions
local neotest = require("neotest")
local dial_map = require("dial.map")

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

local fzf_vim_config = function()
	require("fzf-lua").files({
		cwd = vim.fn.stdpath("config"),
	})
end

-- Buffer, pane, and other navigation
nmap("Next buffer", "L", "<cmd>bnext<cr>")
nmap("Previous buffer", "H", "<cmd>bprevious<cr>")
nmap("Focus pane right", "<c-l>", "<c-w>l")
nmap("Focus pane left", "<c-h>", "<c-w>h")
nmap("Focus pane up", "<c-k>", "<c-w>k")
nmap("Focus pane down", "<c-j>", "<c-w>j")

nmap("Next todo comment", "]t", function()
	require("todo-comments").jump_next()
end)
nmap("Previous todo comment", "[t", function()
	require("todo-comments").jump_prev()
end)

-- <leader>KEY actions, lots of fzf
nmap("Global picker", "<leader><space>", "<cmd>FzfLua global<cr>")
nmap("Files", "<leader>F", "<cmd>FzfLua files<cr>")
nmap("Grep picker", "<leader>/", "<cmd>FzfLua live_grep<cr>")
nmap("Help", "<leader>h", "<cmd>FzfLua helptags<cr>")
nmap("Undo", "<leader>u", "<cmd>FzfLua undotree<cr>")
nmap("Buffers", "<leader>,", "<cmd>FzfLua buffers<cr>")
nmap("Last buffer", "<leader>`", "<cmd>buffer #<cr>")
nmap("Command History", "<leader>:", "<cmd>FzfLua command_history<cr>")
nmap("Notifications", "<leader>n", function()
	Snacks.picker.notifications()
end)
nmap("Spelling Suggestions", "<leader>z", "<cmd>FzfLua spell_suggest<cr>")
nmap("Toggle Scratch Buffer", "<leader>.", function()
	Snacks.scratch()
end)
nmap("Select Scratch Buffer", "<leader>S", function()
	Snacks.scratch.select()
end)
nmap("Toggle Terminal", "<c-/>", function()
	Snacks.terminal()
end)
nmap("which_key_ignore", "<c-_>", function()
	Snacks.terminal()
end)
nmap("File Explorer", "<leader>e", "<cmd>Oil<cr>")
nmap("Mason", "<leader>M", "<cmd>Mason<cr>")
nmap("Toggle Aerial", "<leader>a", "<cmd>AerialToggle!<cr>")

fzf_config.defaults.actions.files["ctrl-t"] = trouble_actions.open

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

nmap("Clear highlighting", "<ESC><ESC>", "<cmd>nohlsearch<cr>")

-- Find leader-menu
wk.add({ "<leader>f", group = "Find" })
nmap("Word", "<leader>fw", "<cmd>FzfLua grep_cword<cr>")
nmap("Lines", "<leader>fl", "<cmd>FzfLua blines<cr>")
nmap("Buffers", "<leader>fb", "<cmd>FzfLua buffers<cr>")
nmap("Recent Files", "<leader>fr", "<cmd>FzfLua oldfiles<cr>")
nmap("Files", "<leader>ff", "<cmd>FzfLua files<cr>")
nmap("Sessions", "<leader>fs", function()
	require("persistence").select()
end)
nmap("Find project", "<leader>fp", "<cmd>ProjectFzf<CR>")
-- TODO: this doesn't jump to the line when I select it
nmap("Find TODOs", "<leader>ft", "<cmd>TodoFzfLua<cr>")
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

-- Config leader-menu
wk.add({ "<leader>C", group = "Config" })
nmap("Vim Config", "<leader>Cv", fzf_vim_config)
nmap("Show local/global JSON config files", "<leader>CC", "<cmd>Neoconf<cr>")
nmap("Show local JSON config files", "<leader>Cl", "<cmd>Neoconf local<cr>")
nmap("Show global JSON config files", "<leader>Cg", "<cmd>Neoconf global<cr>")
nmap("Show merged config", "<leader>Cs", "<cmd>Neoconf show<cr>")
nmap("Show merged LSP config", "<leader>CL", "<cmd>Neoconf lsp<cr>")

-- TODO: quickfix and location lists?

-- Git/JJ leader-menu
wk.add({ "<leader>g", group = "Git/JJ" })
nmap("Git Commit picker", "<leader>gc", "<cmd>FzfLua git_commits<cr>")
nmap("Git File History", "<leader>gh", "<cmd>FzfLua git_bcommits<cr>")
nmap("Git Blame", "<leader>gB", "<cmd>FzfLua git_blame<cr>")
nmap("Git Branches", "<leader>gb", "<cmd>FzfLua git_branches<cr>")
nmap("JJ log", "<leader>gl", "<cmd>JJ log<cr>")

-- UI leader menu
wk.add({ "<leader>u", group = "UI" })
nmap("Colorschemes", "<leader>uC", "<cmd>FzfLua colorschemes<cr>")
nmap("Toggle Zen Mode", "<leader>uz", function()
	Snacks.zen()
end)
nmap("Toggle Zoom", "<leader>uZ", function()
	Snacks.zen.zoom()
end)
nmap("Dismiss All Notifications", "<leader>un", function()
	Snacks.notifier.hide()
end)

-- Quit leader menu
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
nmap("Quit", "<leader>qq", "<cmd>waq<cr>")

-- Buffer leader menu
-- TODO: worth keeping?
wk.add({ "<leader>b", group = "Buffer" })
nmap("Delete Buffer", "<leader>bd", function()
	Snacks.bufdelete()
end)

-- Code leader menu
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

nmap("Rename File", "<leader>cR", function()
	Snacks.rename.rename_file()
end)
nmap("Lint", "<leader>cL", function()
	require("lint").try_lint()
end)
nmap("Symbols (Trouble)", "<leader>cS", "<cmd>Trouble symbols toggle focus=false<cr>")
nmap("LSP definitions ... (Trouble)", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
nmap("Generate annotations", "<leader>cg", "<cmd>Neogen<cr>")

keymap.set({ "n", "x" }, "<leader>cr", function()
	-- this keymap doesn't select any textobject by default, so you may need to provide one each time you use it.
	require("refactoring").select_refactor()
end, { desc = "Select refactor" })

-- Debug leader menu
-- TODO: make these commands more context-aware
-- eg, only load DAP commands when there's a relevant DAP adapter
wk.add({ "<leader>x", group = "Debug" })
nmap("Diagnostics (Trouble)", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
nmap("Buffer Diagnostics (Trouble)", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
nmap("Location List (Trouble)", "<leader>xL", "<cmd>Trouble loclist toggle<cr>")
nmap("Quickfix List (Trouble)", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>")
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

-- Test leader menu
-- Following along from https://tamerlan.dev/setting-up-a-testing-environment-in-neovim/
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

-- Refactoring and Print Refactoring leader menu
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


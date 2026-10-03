
local utils = require("user.utils")

vim.pack.add({
	utils.gh("ibhagwan/fzf-lua"),
  utils.gh("folke/persistence.nvim"),
  utils.gh("ahmedkhalf/project.nvim"),
  utils.gh("jakobwesthoff/project-fzf.nvim"),
  utils.gh("folke/snacks.nvim"),
	utils.gh("nvim-mini/mini.ai"),
	utils.gh("nvim-mini/mini.pairs"),
	utils.gh("nvim-mini/mini.snippets"),
	utils.gh("rafamadriz/friendly-snippets"),
	utils.gh("nvim-mini/mini.surround"),
	utils.gh("nvim-mini/mini.jump2d"),
  utils.gh("stevearc/oil.nvim"),
  utils.gh("folke/neoconf.nvim"),
	utils.gh("saghen/blink.lib"),
	utils.gh("saghen/blink.cmp"),
  utils.gh("monaqa/dial.nvim"),
})

require("fzf-lua").setup({ "fzf-native" })
require("project_nvim").setup({
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".jj", "Justfile", ".justfile" },
})
require("project-fzf").setup()

require("snacks").setup({
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

require("oil").setup()
require("neoconf").setup()

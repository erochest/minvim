
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


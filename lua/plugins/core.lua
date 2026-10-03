
local utils = require("user.utils")

vim.pack.add({
  utils.gh("nvim-lua/plenary.nvim"),
	utils.gh("nvim-tree/nvim-web-devicons"),
	utils.gh("nvim-neotest/nvim-nio"),
	utils.gh("antoinemadec/FixCursorHold.nvim"),
	-- `async.nvim` is only required for Neovim 0.12. If you are using Neovim 0.13, you don't need it
	utils.gh("lewis6991/async.nvim"),
})

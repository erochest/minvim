
local utils = require("user.utils")

vim.pack.add({
	utils.gh("folke/which-key.nvim"),
	utils.gh("shaunsingh/nord.nvim"),
  utils.gh("nvim-lualine/lualine.nvim"),
  utils.gh("lewis6991/gitsigns.nvim"),
  utils.gh("akinsho/bufferline.nvim"),
  utils.gh("folke/trouble.nvim"),
  utils.gh("folke/todo-comments.nvim"),
  utils.gh("stevearc/aerial.nvim"),
})

require("which-key").setup({
	preset = "modern",
})

vim.cmd("colorscheme nord")

require("lualine").setup({
	options = { theme = "nord" },
})

require("bufferline").setup()
require("todo-comments").setup()
require("aerial").setup({
	on_attach = function(bufnr)
    -- TODO: umm. i use the default definition of these
		bnmap(bufnr, "Previous Aerial", "{", "<cmd>AerialPrev<cr>")
		bnmap(bufnr, "Next Aerial", "}", "<cmd>AerialPrev<cr>")
	end,
})

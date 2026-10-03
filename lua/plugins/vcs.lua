
local utils = require("user.utils")

vim.pack.add({
  utils.gh("lewis6991/gitsigns.nvim"),
  utils.gh("jceb/jiejie.nvim"),
})

require("gitsigns").setup()

vim.g.jiejie_config = {
	default_view = 1,
	log_revisions = 10,
}


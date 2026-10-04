
local utils = require("user.utils")

utils.ensure_installed({
  "ast-grep",
  "lua-language-server",
  "selene",
  "stylua",
})

vim.pack.add({
  utils.gh("folke/lazydev.nvim"),
})
require("lazydev").setup()



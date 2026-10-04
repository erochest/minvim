
local utils = require("user.utils")

utils.ensure_installed({
  "sqlfluff",
})

vim.pack.add({
  utils.gh("tpope/vim-dadbod"),
  utils.gh("kristijanhusak/vim-dadbod-completion"),
  utils.gh("kristijanhusak/vim-dadbod-ui"),
})

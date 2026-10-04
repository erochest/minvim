
local utils = require("user.utils")

utils.ensure_installed({
  "ast-grep",
  "codebook",
  "netcoredbg",
  "snyk",
})

vim.pack.add({
  utils.gh("GustavEikaas/easy-dotnet.nvim"),
})
require("easy-dotnet").setup({
})


-- TODO: config
-- TODO: keymaps

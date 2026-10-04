
local utils = require("user.utils")

utils.ensure_installed({
  "fourmolu",
  "haskell-language-server",
  "haskell-debug-adapter",
  "hlint",
})

vim.pack.add {{
  src = 'https://github.com/mrcjkb/haskell-tools.nvim',
  -- To avoid being surprised by breaking changes,
  -- I recommend you set a version range
  version = vim.version.range('^10')
}}
-- TODO: setup keymaps as in https://github.com/mrcjkb/haskell-tools.nvim

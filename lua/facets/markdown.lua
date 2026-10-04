
local utils = require("user.utils")

utils.ensure_installed({
  "alex",
  "codebook",
  "harper-ls",
  "markdown-oxide",
  "markdown-toc",
  "markdownlint-cli2",
  "marksman",
  "vale",
})

vim.pack.add({
  utils.gh("iamcco/markdown-preview.nvim"),
  utils.gh("MeanderingProgrammer/render-markdown.nvim"),
})

require("render-markdown").setup({})


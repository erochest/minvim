
vim.g.mapleader = ","
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

require('vim._core.ui2').enable({})

local gh = function(path)
  return 'https://github.com/' .. path
end

vim.pack.add({
  gh("shaunsingh/nord.nvim"),
})

vim.cmd("colorscheme nord")

vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then
      return
    end
      
    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client_id, args.buf, {
        autotrigger = true,
      })
    end
  end,
})

-- TODO: lsp-config
-- TODO: omnisharp
-- TODO: fzf-lua
-- TODO: which-key
-- TODO: lualine


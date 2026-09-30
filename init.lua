
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

require('vim._core.ui2').enable({})

local gh = function(path)
  return 'https://github.com/' .. path
end

local nmap = function(description, keys, definition)
  vim.keymap.set('n', keys, definition, { silent = true, desc = description })
end

local bnmap = function(buffer, description, keys, definition)
  vim.keymap.set('n', keys, definition, {
    silent = true, desc = description, buffer = buffer,
  })
end

vim.pack.add({
  gh("shaunsingh/nord.nvim"),
})


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

vim.pack.add({
  { src = gh('nvim-tree/nvim-web-devicons') },
})

vim.pack.add({
  { src = gh('folke/which-key.nvim') },
})

local wk = require('which-key')
wk.setup({})

vim.pack.add({
  { src = gh('ibhagwan/fzf-lua') },
})

require('fzf-lua').setup({'fzf-native'})

local fzf_vim_config = function()
  require('fzf-lua').files({
    cwd = vim.fn.stdpath('config'),
  })
end

nmap('Global picker', '<leader><space>', '<cmd>FzfLua global<cr>')
nmap('Files', '<leader>f', '<cmd>FzfLua files<cr>')
nmap('Grep picker', '<leader>/', '<cmd>FzfLua grep<cr>')
nmap('Help', '<leader>h', '<cmd>FzfLua helptags<cr>')
nmap('Undo', '<leader>u', '<cmd>FzfLua undotree<cr>')
nmap('Buffers', '<leader>,', '<cmd>FzfLua buffers<cr>')
nmap('Last buffer', '<leader>\'', '<cmd>buffer #<cr>')
nmap('Directory', '<leader>.', '<cmd>Oil<cr>')

wk.add({ "<leader>s", group = "Search" })
nmap('Buffers', '<leader>sb', '<cmd>FzfLua buffers<cr>')
nmap('Files', '<leader>ss', '<cmd>FzfLua files<cr>')
nmap('Recent Files', '<leader>ss', '<cmd>FzfLua oldfiles<cr>')
nmap('Lines', '<leader>sl', '<cmd>FzfLua blines<cr>')
nmap('Vim Config', '<leader>sv', fzf_vim_config)

wk.add({ "<leader>g", group = "Git/JJ" })
nmap('Git Commit picker', '<leader>gc', '<cmd>FzfLua git_commits<cr>')
nmap('Git File History', '<leader>gh', '<cmd>FzfLua git_bcommits<cr>')
nmap('Git blame', '<leader>gB', '<cmd>FzfLua git_blame<cr>')
nmap('Git branches', '<leader>gb', '<cmd>FzfLua git_branches<cr>')

wk.add({ "<leader>v", group = "Vim" })
nmap('Colorschemes', '<leader>vC', '<cmd>FzfLua colorschemes<cr>')
nmap('Commands', '<leader>vc', '<cmd>FzfLua commands<cr>')
nmap('Jumps', '<leader>vj', '<cmd>FzfLua jumps <cr>')
nmap('Registers', '<leader>vr', '<cmd>FzfLua registers<cr>')
nmap('Options', '<leader>vo', '<cmd>FzfLua options<cr>')
nmap('Keymaps', '<leader>vk', '<cmd>FzfLua keymaps<cr>')

-- DAP pickers
-- dap_commands	list,run nvim-dap builtin commands
-- dap_configurations	list,run debug configurations
-- dap_breakpoints	list,delete breakpoints
-- dap_variables	active session variables
-- dap_frames	active session jump to frame

vim.pack.add({
  { src = gh("nvim-lualine/lualine.nvim") },
})

vim.cmd("colorscheme nord")
require('lualine').setup({
  options = { theme = "nord" },
})

vim.pack.add({
  { src = gh("folke/persistence.nvim") },
})

wk.add({
  { "<leader>q", group = "Quit" },
})

nmap("Load session", "<leader>qs", function() require("persistence").load() end)
nmap("Select session", "<leader>qS", function() require("persistence").select() end)
nmap("Last session", "<leader>ql", function() require("persistence").load({ last = true }) end)
nmap("Stop session saving", "<leader>qd", function() require("persistence").stop() end)

vim.pack.add({
  { src = gh("ahmedkhalf/project.nvim") },
})

require('project_nvim').setup({
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".jj", "Justfile", ".justfile" },
})

vim.pack.add({
  { src = gh("jakobwesthoff/project-fzf.nvim") },
})

require('project-fzf').setup()

-- Map <leader>fp to open projects
nmap("Search projects", "<leader>sp", "<cmd>ProjectFzf<CR>")

vim.pack.add({
  { src = gh("nvimdev/dashboard-nvim") },
})


local dashboard_custom_header = {
 ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
 ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
 ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
 ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
 ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
 ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

-- TODO: how to modify project section?
-- TODO: how to modify mru section?
-- TODO: customize footer. to what?
require('dashboard').setup {
  theme = 'doom',
  config = {
    -- header = dashboard_custom_header,
    footer = {},
    week_header = {
      enable = true,
    },
    project = {
      enable = false,
      action = 'ProjectFzf',
    },
    mru = {
      enable = false,
    },
    center = {
      {
        icon = '\u{ea7b} ',
        desc = 'Browse Files',
        group = 'Label',
        action = 'FzfLua files',
        key = 'f',
        keymap = 'SPC s s',
      },
      {
        icon = '\u{eaf7} ',
        desc = 'Browse Directory',
        group = 'Label',
        action = 'Oil',
        key = 'd',
        keymap = 'SPC .',
      },
      {
        icon = '\u{f12e1} ',
        desc = 'Browse Recent Files',
        group = 'Label',
        action = 'FzfLua oldfiles',
        key = 'r',
        keymap = 'SPC s r',
      },
      {
        icon = '\u{f002} ',
        desc = 'Grep',
        group = 'Label',
        action = 'FzfLua grep',
        key = '/',
        keymap = 'SPC /',
      },
      {
        icon = '\u{ec77} ',
        desc = 'Sessions',
        group = 'Label',
        action = function() require("persistence").select() end,
        key = 's',
        keymap = 'SPC q S',
      },
      {
        icon = '\u{f502} ',
        desc = 'Projects',
        group = 'Label',
        action = 'ProjectFzf',
        key = 'p',
        keymap = 'SPC s p',
      },
      {
        icon = '\u{f128d} ',
        desc = 'Mason',
        group = 'Config',
        action = 'Mason',
        key = 'm',
        keymap = 'SPC v m',
      },
      {
        icon = '\u{e62b} ',
        desc = 'Vim',
        group = 'Config',
        action = fzf_vim_config,
        key = 'v',
        keymap = 'SPC s v',
      },
    },
  },
}


vim.pack.add({
    gh('stevearc/oil.nvim'),
})
require("oil").setup()
nmap("Browse cwd", "<leader>sd", "<cmd>Oil<cr>")


vim.pack.add{
  { src = gh('neovim/nvim-lspconfig') },
  { src = gh("mason-org/mason.nvim") },
}

require("mason").setup()
nmap("Mason", "<leader>v", "<cmd>Mason<cr>")

wk.add({ "<leader>c", group = "Code" })
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local fzf = require('fzf-lua')

    bnmap(ev.buffer, "Definitions", "gd", fzf.lsp_definitions)
    bnmap(ev.buffer, "Declarations", "gd", fzf.lsp_declarations)
    bnmap(ev.buffer, "Type definition", "<leader>ct", fzf.lsp_typedefs)

    bnmap(ev.buffer, "References", "grr", fzf.lsp_references)
    bnmap(ev.buffer, "Implementations", "gri", fzf.lsp_implementations)

    bnmap(ev.buffer, "Symbols", "<leader>cs", fzf.lsp_document_symbols)
    bnmap(ev.buffer, "Workspace Symbols", "<leader>cw", fzf.lsp_live_workspace_symbols)

    bnmap(ev.buffer, "Buffer Diagnostics", "<space>cx", fzf.diagnostics_document)
    bnmap(ev.buffer, "Workspace Diagnostics", "<leader>cX", fzf.diagnostics_workspace)

    bnmap(ev.buffer, "Hover", "K", vim.lsp.buf.hover)
  end,
})

-- TODO: nvim-dap

-- TODO: jump and other QOL stuff
-- TODO: omnisharp or other dotnet plugin
-- TODO: function and keybinding to update packages

-- Path to your local configuration file
local local_config = vim.fn.stdpath("config") .. "/lua/local.lua"

-- Check if the local file exists before loading it
if vim.fn.filereadable(local_config) == 1 then
  require("local")
end

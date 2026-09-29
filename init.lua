
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
nmap('Grep picker', '<leader>/', '<cmd>FzfLua grep<cr>')
nmap('Help', '<leader>h', '<cmd>FzfLua helptags<cr>')
nmap('Undo', '<leader>u', '<cmd>FzfLua undotree<cr>')
nmap('Buffers', '<leader>,', '<cmd>FzfLua buffers<cr>')
nmap('Last buffer', '<leader>\'', '<cmd>buffer #<cr>')

wk.add({ "<leader>s", group = "Search" })
nmap('Buffers', '<leader>sb', '<cmd>FzfLua buffers<cr>')
nmap('Files', '<leader>ss', '<cmd>FzfLua files<cr>')
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

-- LSP pickers
-- lsp_references	References
-- lsp_definitions	Definitions
-- lsp_declarations	Declarations
-- lsp_typedefs	Type Definitions
-- lsp_implementations	Implementations
-- lsp_document_symbols	Document Symbols
-- lsp_workspace_symbols	Workspace Symbols
-- lsp_live_workspace_symbols	Workspace Symbols (live query)
-- lsp_incoming_calls	Incoming Calls
-- lsp_outgoing_calls	Outgoing Calls
-- lsp_type_sub	Sub Types
-- lsp_type_super	Super Types
-- lsp_code_actions	Code Actions
-- lsp_finder	All LSP locations, combined view
-- diagnostics_document	Document Diagnostics
-- diagnostics_workspace	Workspace Diagnostics
-- lsp_document_diagnostics	alias to diagnostics_document
-- lsp_workspace_diagnostics	alias to diagnostics_workspace

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
    shortcut = {
      {
        icon = '\u{ea7b} ',
        desc = 'Files',
        group = 'Label',
        action = 'FzfLua files',
        key = 'f',
      },
      {
        icon = '\u{f12e1} ',
        desc = 'Recent Files',
        group = 'Label',
        action = 'FzfLua oldfiles',
        key = 'r',
      },
      {
        icon = '\u{f002} ',
        desc = 'Grep',
        group = 'Label',
        action = 'FzfLua grep',
        key = '/',
      },
      {
        icon = '\u{ec77} ',
        desc = 'Sessions',
        group = 'Label',
        action = function() require("persistence").select() end,
        key = 's',
      },
      {
        icon = '\u{f502} ',
        desc = 'Projects',
        group = 'Label',
        action = 'ProjectFzf',
        key = 'p',
      },
      {
        icon = '\u{e62b} ',
        desc = 'Vim Config',
        group = 'Label',
        action = fzf_vim_config,
        key = 'v',
      },
    },
  },
}

-- TODO: publish to github
-- TODO: lsp-config
-- TODO: omnisharp or other dotnet plugin
-- TODO: nvim-dap
-- TODO: function and keybinding to update packages


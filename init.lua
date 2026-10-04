
require("config.options")

require("plugins.core")
require("plugins.code")
require("plugins.ui")
require("plugins.utils")
require("plugins.vcs")

require("config.keymaps")

-- TODO:
-- fzf: DAP pickers
-- dap_commands	list,run nvim-dap builtin commands
-- dap_configurations	list,run debug configurations
-- dap_breakpoints	list,delete breakpoints
-- dap_variables	active session variables
-- dap_frames	active session jump to frame

-- TODO: border around LSP hover window
-- TODO: function and keybinding to update packages
-- TODO: edgy
-- TODO: nvim-navic and nvim-navbuddy

-- TODO: maybe have an env var that contains optional language config to load.
-- For instance, ':python:golang:rust:' loads lang.python, lang.golang, and lang.rust
-- this would load the dap packages and others for these languages.
-- This could replace or augment the local package below.

-- Path to your local configuration file
local local_config = vim.fn.stdpath("config") .. "/lua/local.lua"

-- Check if the local file exists before loading it
if vim.fn.filereadable(local_config) == 1 then
	require("local")
end

-- Facets are packages that are run optionally, triggered by including them
-- in the MINVIM_FACETS environment variable. Each facet is delimited by
-- a ':' character. For instance, to load the Python, Go, and Rust facets:
--
-- > `:python:golang:rust:`
--
-- Each facet needs to have a corresponding package in the 'lua/facets'
-- directory of the configuration. The initial use case for this is making
-- sure that Mason has the right packages loaded for a given language, and
-- standardizing those packages across the computers I work on.
--
-- TODO: have this cover treesitters too
-- TODO: also conform, nvim-dap, and neotest configs
-- TODO: make this a package?
-- TODO: move the implementation for this into a package
local facet_spec = os.getenv("MINVIM_FACETS")
if facet_spec ~= nil then
  local facets = vim.split(facet_spec, ":")
  for _, facet_name in ipairs(facets) do
    if facet_name ~= "" then
      local facet_file = vim.fn.stdpath("config") .."/lua/facets/" .. facet_name .. ".lua"
      if vim.fn.filereadable(facet_file) == 1 then
        -- vim.notify("Loading facet " .. facet_name, vim.log.levels.INFO)
        require("facets." .. facet_name)
      else
        vim.notify("Missing package for facet " .. facet_name, vim.log.levels.WARN)
      end
    end
  end
end

local utils = require("user.utils")
vim.pack.add({
  utils.gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})
require("mason-tool-installer").setup({
  ensure_installed=utils.get_ensure_installed(),
})

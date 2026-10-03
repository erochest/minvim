
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

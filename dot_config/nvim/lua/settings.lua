-- Set the colorscheme to TokyoNight
-- Available options:
--   tokyonight       (alias for tokyonight-storm)
--   tokyonight-day
--   tokyonight-moon
--   tokyonight-night
--   tokyonight-storm
vim.cmd([[colorscheme tokyonight-storm]])

-- Set the <Space> key as the map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Insert indents automatically

-- Set the Python host program for Neovim
local nvim_config_dir = vim.fn.stdpath("config")
local venv_path = nvim_config_dir .. "/.venv/bin/python"
vim.g.python3_host_prog = venv_path

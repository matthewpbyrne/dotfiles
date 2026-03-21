-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local python_host = os.getenv("NVIM_PYTHON_HOST")
if python_host and vim.fn.executable(python_host) == 1 then
  vim.g.python3_host_prog = python_host
end

local ruby_host = os.getenv("NVIM_RUBY_HOST")
if ruby_host and vim.fn.executable(ruby_host) == 1 then
  vim.g.ruby_host_prog = ruby_host
end

vim.g.loaded_perl_provider = 0

-- Uncomment if you do not use node-based Neovim providers
-- vim.g.loaded_node_provider = 0

-- enable project-local config via  .nvim.lua, .nvimrc, or .exrc
vim.o.exrc = true
vim.o.secure = true
vim.g.autoformat = true

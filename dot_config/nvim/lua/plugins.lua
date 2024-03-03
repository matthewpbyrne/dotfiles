local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Define the plugins in a table
local plugins = {

	-- Commenting
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- LSP and Autocompletion
	"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-path",
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Syntax highlighting and additional language support
	"nvim-treesitter/nvim-treesitter",
	"jim-at-jibba/ariake-vim-colors",
	"folke/tokyonight.nvim",

	-- Python development
	-- (No specific plugins mentioned for Python development)

	-- Shell scripting
	"shirk/vim-gas", -- Syntax highlighting for shell scripts

	-- Navigation
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x", -- Make sure to specify the correct branch
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-vim-test",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}

-- Require lazy and setup the plugins
require("lazy").setup(plugins)

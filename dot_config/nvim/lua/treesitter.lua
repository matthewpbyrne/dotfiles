require("nvim-treesitter.configs").setup({
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = false,

	highlight = {
		enable = true, -- `false` will disable the whole extension
		-- disable = { "c", "typescript" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	-- Configuration for indentation (experimental feature)
	indent = {
		enable = true, -- Enable treesitter-based indentation for supported languages
	},
})
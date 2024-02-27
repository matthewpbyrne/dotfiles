local none_ls = require("null-ls")

none_ls.setup({
	sources = {
		-- Lua
		none_ls.builtins.formatting.stylua,

		-- Python
		none_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),

		-- JavaScript
		none_ls.builtins.formatting.prettier.with({ filetypes = { "javascript", "json", "typescript" } }),

		-- All filetypes
		none_ls.builtins.completion.spell,
	},
})

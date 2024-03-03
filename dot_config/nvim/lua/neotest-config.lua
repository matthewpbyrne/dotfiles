require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- Python-specific configuration
			-- Adjust based on your testing framework, e.g., pytest, unittest
			runner = "pytest",
		}),
		require("neotest-plenary"),
		require("neotest-vim-test")({
			-- Configuration for non-Lua tests
		}),
	},
	-- General configuration options
	summary = {
		-- Controls the behavior of the test result window
		expand_errors = true,
		follow = true,
	},
	-- Additional customization...
})

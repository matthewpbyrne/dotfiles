-- require("neotest").setup({
-- 	adapters = {
-- 		require("neotest-python")({
-- 			-- Python-specific configuration
-- 			-- Adjust based on your testing framework, e.g., pytest, unittest
-- 			runner = "pytest",
-- 		}),
-- 		require("neotest-plenary"),
-- 		require("neotest-vim-test")({
-- 			-- Configuration for non-Lua tests
-- 		}),
-- 	},
-- 	-- General configuration options
-- 	summary = {
-- 		-- Controls the behavior of the test result window
-- 		expand_errors = true,
-- 		follow = true,
-- 	},
-- 	-- Additional customization...
-- })

require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- Python-specific configuration
			-- Adjust based on your testing framework, e.g., pytest, unittest
			runner = "pytest",
		}),
		-- require("neotest-python"),
		require("neotest-plenary"),
		require("neotest-jest")({
			jestCommand = "npm test -- --json --outputFile=test_output.json",
			-- jestCommand = "npm test --", -- or your specific Jest command
			env = { CI = true }, -- Environment variables to be set when running tests
			cwd = function(path)
				print("path:", path)
				print("cwd", vim.fn.getcwd())
				return vim.fn.getcwd()
			end,
		}),
	},
})

-- require("neotest").setup({
-- 	adapters = {
-- 		require("neotest-python")({
-- 			-- Extra arguments for nvim-dap configuration
-- 			-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
-- 			dap = { justMyCode = false },
-- 			-- Command line arguments for runner
-- 			-- Can also be a function to return dynamic values
-- 			args = { "--log-level", "DEBUG" },
-- 			-- Runner to use. Will use pytest if available by default.
-- 			-- Can be a function to return dynamic value.
-- 			runner = "pytest",
-- 			-- Custom python path for the runner.
-- 			-- Can be a string or a list of strings.
-- 			-- Can also be a function to return dynamic value.
-- 			-- If not provided, the path will be inferred by checking for
-- 			-- virtual envs in the local directory and for Pipenev/Poetry configs
-- 			python = ".venv/bin/python",
-- 			-- Returns if a given file path is a test file.
-- 			-- NB: This function is called a lot so don't perform any heavy tasks within it.
-- 			-- is_test_file = function(file_path)
-- 			--   ...
-- 			-- end,
-- 			-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
-- 			-- instances for files containing a parametrize mark (default: false)
-- 			pytest_discover_instances = true,
-- 		}),
-- 	},
-- })

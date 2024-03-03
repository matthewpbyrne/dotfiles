local map = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }
local opts = { noremap = true, silent = false }

map("n", "<leader>w", ":write<CR>", opts)
map("n", "<leader>p", ":lua print_hello()<CR>", opts)
map("n", "<leader>r", ":lua reload_config()<CR>", opts)

-- Neotree
map("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)

---------------------------------
--          Neotest            --
---------------------------------
-- Run tests for the current file
map("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
map("n", "<leader>tg", ":lua matt_test()<CR>", opts)

-- Run the nearest test to the cursor
--                           require("neotest").run.run()
map("n", "<leader>tt", ':lua require("neotest").run.run()<CR>', opts)
-- Run all tests in the project
map("n", "<leader>ta", ':lua require("neotest").run.run({suite = true})<CR>', opts)
-- map("n", "<leader>ta", ":lua require('neotest').run.run({suite = true})<CR>", opts)

local function run_tests_and_log()
	-- Attempt to run the test suite
	require("neotest").run.run({ suite = true })
	-- Diagnostic information to capture
	local diagnostic_info = {
		nvim_version = vim.version(), -- Neovim version information
		current_working_directory = vim.fn.getcwd(), -- Current working directory
		package_path = package.path, -- Lua module search path
		package_cpath = package.cpath, -- Compiled module search path
	}
	-- Convert diagnostic information to a human-readable string
	local info_str = vim.inspect(diagnostic_info)
	-- Path to the log file
	local log_file_path = vim.fn.stdpath("data") .. "/neotest_debug_log.txt"
	-- Write the diagnostic information to the log file
	local file = io.open(log_file_path, "w")
	if file then
		file:write(info_str)
		file:close()
		print("Diagnostic info written to: " .. log_file_path)
	else
		print("Failed to open log file for writing.")
	end
end

-- vim.keymap.set(
-- 	"n",
-- 	"<leader>ta",
-- 	run_tests_and_log,
-- 	{ noremap = true, silent = true, desc = "Run tests and log diagnostics" }
-- )

-- vim.keymap.set("n", "<leader>ta", function()
-- 	require("neotest").run.run({ suite = true })
-- end, { noremap = true, silent = true, desc = "Run all tests" })

-- Open test summary (to see all results)
map("n", "<leader>ts", ':lua require("neotest").summary.toggle()<CR>', opts)
-- Jump to the next failed test from anywhere
map("n", "<leader>tn", ':lua require("neotest").diagnostics.goto_next()<CR>', opts)
-- Jump to the previous failed test from anywhere
map("n", "<leader>tp", ':lua require("neotest").diagnostics.goto_prev()<CR>', opts)
-- Stop the currently running test (if supported by the adapter)
map("n", "<leader>tx", ':lua require("neotest").run.stop()<CR>', opts)
-- View test output of the nearest test
-- map("n", "<leader>to", ':lua require("neotest").output.open({ enter = true, short = true })<CR>', opts)
-- map("n", "<leader>to", ':lua require("neotest").output.open({ enter = true, short = false })<CR>', opts)

map("n", "<leader>to", ':lua require("neotest").output_panel.toggle()<CR>', opts)

-- map("n", "<leader>tr",
-- ":lua print(vim.fn.stdpath('cache') .. '/neotest.log')."

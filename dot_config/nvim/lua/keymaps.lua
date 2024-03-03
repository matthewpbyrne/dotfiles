local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
-- Run the nearest test to the cursor
map("n", "<leader>tn", ':lua require("neotest").run.run()<CR>', opts)
-- Run all tests in the project
map("n", "<leader>ta", ':lua require("neotest").run.run({suite = true})<CR>', opts)
-- Open test summary (to see all results)
map("n", "<leader>ts", ':lua require("neotest").summary.toggle()<CR>', opts)
-- Jump to the next failed test from anywhere
map("n", "<leader>tn", ':lua require("neotest").diagnostics.goto_next()<CR>', opts)
-- Jump to the previous failed test from anywhere
map("n", "<leader>tp", ':lua require("neotest").diagnostics.goto_prev()<CR>', opts)
-- Stop the currently running test (if supported by the adapter)
map("n", "<leader>tx", ':lua require("neotest").run.stop()<CR>', opts)
-- View test output of the nearest test
map("n", "<leader>to", ':lua require("neotest").output.open({ enter = true, short = true })<CR>', opts)

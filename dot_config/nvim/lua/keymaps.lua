local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<leader>w", ":write<CR>", opts)
map("n", "<leader>p", ":lua print_hello()<CR>", opts)
map("n", "<leader>r", ":lua reload_config()<CR>", opts)

-- Neotree
map("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)

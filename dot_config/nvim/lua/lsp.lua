local nvim_lsp = require("lspconfig")

--------------------------------------------------
-- Setup LSP servers
--------------------------------------------------
local map = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }

	-- Navigation
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

	-- Information
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	-- Diagnostic keymaps
	buf_set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	-- Refactoring
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	-- Formatting
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

	-- Code action
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Configure Python LSP with pyright
-- (can be installed with: npm install -g pyright)
nvim_lsp.pyright.setup({ on_attach = on_attach })

-- JavaScript and TypeScript
-- (can be installed with: pnpm install -g typescript-language-server typescript)
nvim_lsp.tsserver.setup({ on_attach = on_attach })

-- Lua
nvim_lsp.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			-- Get the language server to recognize the `vim` global
			diagnostics = { globals = { "vim" } },
			-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			runtime = { version = "LuaJIT" },
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
			-- Make the server aware of Neovim runtime files
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
})

--------------------------------------------------
-- Auto-format files on save
--------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.py", "*.lua", "*.js", "*.ts" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

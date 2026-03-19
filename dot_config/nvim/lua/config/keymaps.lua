-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Neotest
map("n", "<leader>tt", function()
  require("neotest").run.run()
end, { desc = "Run Nearest Test" })

map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run Test File" })

map("n", "<leader>tT", function()
  require("neotest").run.run(vim.loop.cwd())
end, { desc = "Run Test Suite" })

map("n", "<leader>ta", function()
  require("neotest").run.attach()
end, { desc = "Attach to Test" })

map("n", "<leader>to", function()
  require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Open Test Output" })

map("n", "<leader>tO", function()
  require("neotest").output_panel.toggle()
end, { desc = "Toggle Test Output Panel" })

map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle Test Summary" })

map("n", "<leader>tw", function()
  require("neotest").watch.toggle(vim.fn.expand("%"))
end, { desc = "Watch Test File" })

map("n", "<leader>td", function()
  ---@diagnostic disable-next-line: param-type-mismatch
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug Nearest Test" })

map("n", "<leader>tl", function()
  require("neotest").run.run_last()
end, { desc = "Run Last Test" })

-- DAP
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue Debugging" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })

map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step Over" })

map("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "Step Out" })

map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open Debug REPL" })

map("n", "<leader>dq", function()
  require("dap").terminate()
end, { desc = "Terminate Debug Session" })

return {
  -- This is added in `LazyExtras`
  -- { import = "lazyvim.plugins.extras.ai.copilot" },

  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
    },
  },

  {
    "kkrampis/codex.nvim",
    cmd = { "Codex", "CodexToggle" },
    keys = {
      { "<leader>ac", "<cmd>CodexToggle<cr>", desc = "Codex Toggle", mode = { "n", "t" } },
    },
    opts = {},
  },
}

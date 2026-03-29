return {
  {
    "laktak/tome",
    cmd = { "Tome" },
    keys = {
      { "<leader>ot", "<cmd>Tome<cr>", desc = "Open Tome" },
    },
    init = function()
      vim.g.tome_playbook = ".playbook.sh"
      vim.g.tome_editor = "nvim"
    end,
  },
}

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>td",
        function()
          ---@diagnostic disable-next-line: param-type-mismatch
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },
    },
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("python")
    end,
  },
}

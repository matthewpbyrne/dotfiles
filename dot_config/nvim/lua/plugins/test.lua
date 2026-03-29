return {
  { "nvim-neotest/neotest-plenary" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
    },
    opts = {
      adapters = {
        "neotest-plenary",

        ["neotest-python"] = {
          runner = "pytest",
          dap = { justMyCode = false },
        },

        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
}

return {
  "nvim-neotest/neotest",
  dependencies = {
    "stevearc/overseer.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-vim-test",
    "vim-test/vim-test",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "mfussenegger/nvim-dap-python",
  },
  ft = {
    "python",
    "go",
    "java",
  },
}

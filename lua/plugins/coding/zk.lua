return {
  "mickael-menu/zk-nvim",
  dependency = { "nvim-telescope/telescope.nvim" },
  opts = {
    picker = "telescope",
    lsp = {
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
      },
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  },
  config = function(_, opts)
    require("telescope").load_extension("zk")
    require("zk").setup(opts)
  end,
  keys = {
    {
      "<leader>zn",
      "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
      desc = "New Note",
    },
    { "<leader>zz", vim.cmd.ZkNotes, desc = "Browse Notes" },
    { "<leader>zg", "<cmd>Telescope live_grep cwd=~/notes<cr>", desc = "Find Notes" },
  },
}

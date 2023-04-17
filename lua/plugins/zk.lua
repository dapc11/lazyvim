return {
  "mickael-menu/zk-nvim",
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
    require("zk").setup(opts)
  end,
  keys = {
    {
      "<leader>zn",
      "<Cmd>ZkNew { dir = vim.fn.expand('$HOME/notes'), title = vim.fn.input('Title: ') }<CR>",
      desc = "New Note",
    },
    { "<leader>zb", vim.cmd.ZkNotes, desc = "Browse Notes" },
    { "<leader>zz", "<cmd>Telescope live_grep cwd=~/notes<cr>", desc = "Find Notes" },
  },
}

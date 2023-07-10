return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewRefresh",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
  },
  keys = {
    { "<leader>gq", vim.cmd.DiffviewClose, "Diffview Close" },
    { "<leader>gd", vim.cmd.DiffviewOpen, "Diffview (all modified files)" },
    {
      "<leader>gl",
      function()
        vim.cmd.DiffviewFileHistory("%")
      end,
      "Diffview current file history",
    },
  },
}

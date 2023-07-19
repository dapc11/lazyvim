return {
  {
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
      { "<leader>gq", vim.cmd.DiffviewClose, desc = "Diffview Close" },
      { "<leader>gd", vim.cmd.DiffviewOpen, desc = "Diffview (all modified files)" },
      {
        "<leader>gl",
        function()
          vim.cmd.DiffviewFileHistory("%")
        end,
        desc = "Diffview current file history",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+Git" },
      },
    },
  },
}

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+Git" },
      },
    },
  },
  {
    "dapc11/vim-fugitive",
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },
  {
    "NeogitOrg/neogit",
    keys = { { "<C-g>", "<cmd>Neogit<cr>" } },
    config = true,
    dependencies = "nvim-lua/plenary.nvim",
  },
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
    -- stylua: ignore
    keys = {
      { "<leader>gq", vim.cmd.DiffviewClose, desc = "Diffview Close" },
      { "<leader>gd", vim.cmd.DiffviewOpen, desc = "Diffview (all modified files)" },
      { "<leader>gl", function() vim.cmd.DiffviewFileHistory("%") end, desc = "Diffview Current File History" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>gB", require("telescope.builtin").git_branches, desc = "Checkout Branch" },
      { "<leader>gC", require("telescope.builtin").git_commits, desc = "Checkout Commit" },
      { "<leader>n", require("telescope.builtin").git_files, desc = "Find Tracked Files" },
      { "<leader>N", function() require("telescope.builtin").git_files({ git_command = { "git", "ls-files", "--modified", "--exclude-standard" }, }) end, desc = "Find Tracked Files" },
    },
  },
}

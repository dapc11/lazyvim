return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+Git" },
        ["<leader>gp"] = { name = "+Push" },
        ["<leader>gh"] = { name = "+Hunk" },
      },
    },
  },
  {
    "dapc11/vim-fugitive",
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<leader>gpg", "<cmd>Git push origin HEAD:refs/for/master<cr>", desc = "Push Gerrit" },
      { "<leader>gpp", "<cmd>Git push<cr>", desc = "Push Regular" },
      { "<leader>gb",  "<cmd>Git blame<cr>", desc = "Git Blame" },
      { "<leader>gf",  "<cmd>Git fetch<cr>", desc = "Git Fetch" },
      { "<leader>gr",  "<cmd>Git pull --rebase<cr>", desc = "Git Pull Rebase" },
      { "<leader>gL",  "<cmd>Git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<cr>", desc = "Git log" },
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
      { "<leader>gc", nil },
      { "<leader>n",  require("telescope.builtin").git_files, desc = "Find Tracked Files" },
      { "<leader>N",  function() require("telescope.builtin").git_files({ git_command = { "git", "ls-files", "--modified", "--exclude-standard" }, }) end, desc = "Find Tracked Files" },
    },
  },
}

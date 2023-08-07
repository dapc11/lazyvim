return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+git" },
        ["<leader>gp"] = { name = "+push" },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "<h", gs.next_hunk, "Next Hunk")
        map("n", ">h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hd", gs.diffthis, "Diff This")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
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
      { "<leader>gh", function() vim.cmd.DiffviewFileHistory("%") end, desc = "Diffview Current File History" },
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

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      vim.keymap.set("n", "<c", function()
        if vim.wo.diff then
          return "]czz"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
          vim.fn.feedkeys("zz")
        end)
        return "<Ignore>"
      end, { expr = true })

      vim.keymap.set("n", ">c", function()
        if vim.wo.diff then
          return "[czz"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
          vim.fn.feedkeys("zz")
        end)
        return "<Ignore>"
      end, { expr = true })
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },

  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose", -- also can use :tabclose
      "DiffviewFileHistory",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    keys = {
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview (all modified files)" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview current file history" },
    },
  },

  {
    "dapc11/vim-fugitive",
    keys = {
      { "<C-g>", vim.cmd.Git, desc = "Git" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
      { "<leader>gg", vim.cmd.Git, desc = "Git" },
      { "<leader>gl", vim.cmd.Gclog, desc = "Log" },
    },
  },
}

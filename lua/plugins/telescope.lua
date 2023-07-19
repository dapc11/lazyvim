local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "dapc11/telescope-yaml.nvim",
      ft = "yaml",
      config = function()
        require("telescope").load_extension("telescope-yaml")
      end,
    },
  },
  keys = {
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    { "<leader>n", require("telescope.builtin").git_files, desc = "Find Tracked Files" },
    {
      "<leader>N",
      function()
        require("telescope.builtin").git_files({
          git_command = { "git", "ls-files", "--modified", "--exclude-standard" },
        })
      end,
      desc = "Find Tracked Files",
    },
    { "<leader>b", require("telescope.builtin").buffers, desc = "Find Buffers" },
    { "<leader>r", require("telescope.builtin").oldfiles, desc = "Find Recent Files" },
    { "<leader><leader>", require("telescope.builtin").live_grep, desc = "Live Grep" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        i = {
          ["<C-p>"] = action_layout.toggle_preview,
          ["<C-c>"] = actions.close,
          ["<esc>"] = actions.close,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-o>"] = actions.select_tab,
        },
        n = {
          ["<c-c>"] = actions.close,
          ["<c-p>"] = action_layout.toggle_preview,
          ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<c-down>"] = actions.cycle_history_next,
          ["<c-up>"] = actions.cycle_history_prev,
        },
      },
    },
  },
}

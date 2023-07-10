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
    { "<C-f>", require("telescope.builtin").current_buffer_fuzzy_find, desc = "Find in Current Buffer" },
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
    { "<leader>r", require("telescope.builtin").oldfiles, desc = "Find Tracked Files" },
    { "<leader><leader>", require("telescope.builtin").live_grep, desc = "Live Grep" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },
  },
}

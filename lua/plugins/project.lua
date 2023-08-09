return {
  {
    "dapc11/project.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    opts = {
      active = true,
      on_config_done = nil,
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = {
        "ruleset2.0.yaml",
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "script_version.txt",
        "drc-report",
        "image-design-rule-check-report.html",
      },
      ignore_lsp = {},
      exclude_dirs = {},
      show_hidden = true,
      silent_chdir = true,
      scope_chdir = "global",
      datapath = vim.fn.stdpath("data"),
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-p>", "<cmd>Telescope projects<cr>", desc = "Find Project" },
    },
  },
}

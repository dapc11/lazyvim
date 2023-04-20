return {
  "dapc11/project.nvim",
  dependency = { "nvim-telescope/telescope.nvim" },
  event = "VeryLazy",
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension("projects")
  end,
  keys = {
    { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    { "<C-p>", "<Cmd>Telescope projects<CR>", desc = "Projects" },
  },
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
}

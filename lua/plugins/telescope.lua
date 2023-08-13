local actions = require("telescope.actions")

return {
  {
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
    },
    keys = function()
      return {}
    end,
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        -- stylua: ignore
        mappings = {
          i = {
            ["<C-q>"] = function(...) return require("trouble.providers.telescope").smart_open_with_trouble(...) end,
            ["<C-i>"] = function() local line = require("telescope.actions.state").get_current_line() require("lazyvim.util").telescope("find_files", { no_ignore = true, default_text = line })() end,
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            ["<Esc>"] = require("telescope.actions").close,
            ["<C-x>"] = actions.toggle_selection + actions.move_selection_next,
            ["<C-z>"] = actions.move_selection_previous + actions.toggle_selection,
            ["<C-Down>"] = require("telescope.actions").cycle_history_next,
            ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
            ["<CR>"] = require("telescope.actions").select_default,
            ["<C-h>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
          },
          n = {
            ["<C-c>"] = require("telescope.actions").close,
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            ["<C-q>"] = function(...) return require("trouble.providers.telescope").smart_open_with_trouble(...) end,
            ["<C-down>"] = require("telescope.actions").cycle_history_next,
            ["<C-up>"] = require("telescope.actions").cycle_history_prev,
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    keys = function()
    -- stylua: ignore
      return {
        { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
        { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
        { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
        { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      }
    end,
  },
}

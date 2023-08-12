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
    { "<leader>r", require("telescope.builtin").oldfiles, desc = "Find Recent Files" },
    { "<leader><leader>", require("telescope.builtin").live_grep, desc = "Live Grep" },
    {
      "<leader><leader>",
      function()
        local function getVisualSelection()
          vim.cmd('noau normal! "vy"')
          local text = vim.fn.getreg("v")
          vim.fn.setreg("v", {})

          text = string.gsub(text, "\n", "")
          if #text > 0 then
            return text
          else
            return ""
          end
        end
        require("telescope.builtin").live_grep({ default_text = getVisualSelection() })
      end,
      mode = "v",
      desc = "Live Grep Selection",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        i = {
          ["<c-q>"] = function(...)
            return require("trouble.providers.telescope").smart_open_with_trouble(...)
          end,
          ["<c-i>"] = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            require("lazyvim.util").telescope("find_files", { no_ignore = true, default_text = line })()
          end,
          ["<c-p>"] = action_layout.toggle_preview,
          ["<c-c>"] = actions.close,
          ["<esc>"] = actions.close,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<c-Down>"] = actions.cycle_history_next,
          ["<c-Up>"] = actions.cycle_history_prev,
          ["<CR>"] = actions.select_default,
          ["<c-h>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
          ["<c-o>"] = actions.select_tab,
        },
        n = {
          ["<c-c>"] = actions.close,
          ["<c-p>"] = action_layout.toggle_preview,
          ["<c-q>"] = function(...)
            return require("trouble.providers.telescope").smart_open_with_trouble(...)
          end,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<c-down>"] = actions.cycle_history_next,
          ["<c-up>"] = actions.cycle_history_prev,
        },
      },
    },
  },
}

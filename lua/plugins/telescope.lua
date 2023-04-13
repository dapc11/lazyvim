local Util = require("lazyvim.util")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
    { "<leader>n", Util.telescope("files"), desc = "Find Files" },
    {
      "<leader>N",
      Util.telescope("git_files", { git_command = { "git", "ls-files", "--modified", "--exclude-standard" } }),
      desc = "Find Unstaged Files",
    },
    -- find
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>h", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    {
      "<leader>fd",
      Util.telescope("find_files", {
        cwd = "~/repos/",
        prompt_title = "Repos",
        layout_config = {
          height = 0.85,
          width = 0.75,
        },
      }),
      desc = "Find Repo Files",
    },
    {
      "<leader>fg",
      Util.telescope("live_grep", {
        cwd = "~/repos/",
        path_display = { "truncate", shorten = { len = 1, exclude = { 1, -1 } } },
        prompt_title = "Repos",
        layout_config = {
          height = 0.85,
          width = 0.75,
        },
      }),
      desc = "Find in Repo Files",
    },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    {
      "<leader><leader>",
      Util.telescope("live_grep", { path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } } }),
      desc = "Grep (root dir)",
    },
    { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
    { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
    {
      "<leader>ss",
      Util.telescope("lsp_document_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      Util.telescope("lsp_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol (Workspace)",
    },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<c-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<a-t>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
          ["<a-i>"] = function()
            Util.telescope("find_files", { no_ignore = true })()
          end,
          ["<a-h>"] = function()
            Util.telescope("find_files", { hidden = true })()
          end,
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
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["<C-c>"] = actions.close,
          ["<C-p>"] = action_layout.toggle_preview,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
        },
      },
    },
  },
}

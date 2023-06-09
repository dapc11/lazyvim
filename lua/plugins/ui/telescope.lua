local Util = require("lazyvim.util")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")

local multi_select_action = function(pb)
  local picker = action_state.get_current_picker(pb)
  local multi = picker:get_multi_selection()
  actions.select_default(pb) -- the normal enter behaviour
  for _, j in pairs(multi) do
    if j.path ~= nil then -- is it a file -> open it as well:
      vim.cmd(string.format("%s %s", "edit", j.path))
    end
  end
end

function vim.getVisualSelection()
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
      "s1n7ax/nvim-window-picker",
      version = "v1.*",
      opts = {
        selection_chars = "abcdefghklmnopqrstuvw",
        fg_color = "#cdd9e5",
        current_win_hl_color = "#347d39",
        other_win_hl_color = "#316dca",
      },
      config = function(_, opts)
        require("window-picker").setup(opts)
      end,
    },
  },
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>n", Util.telescope("git_files"), desc = "Find Files" },
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
        prompt_title = "Find File in Repos",
      }),
      desc = "Find Repo Files",
    },
    {
      "<leader>fg",
      Util.telescope("live_grep", {
        cwd = "~/repos/",
        path_display = { "truncate", shorten = { len = 1, exclude = { 1, -1 } } },
        prompt_title = "Grep in Repos",
      }),
      desc = "Find in Repo Files",
    },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    { "<leader>gB", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
    -- search
    { "<C-s>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    {
      "<leader>ss",
      function()
        local text = vim.getVisualSelection()
        require("telescope.builtin").current_buffer_fuzzy_find({ default_text = text })
      end,
      desc = "Current Buffer Grep Selection",
      mode = "v",
    },
    {
      "<leader><space>",
      Util.telescope("live_grep", { path_display = { "truncate", shorten = { len = 3, exclude = { 1, -1 } } } }),
      desc = "Grep (root dir)",
    },
    {
      "<leader><leader>",
      function()
        local text = vim.getVisualSelection()
        require("telescope.builtin").live_grep({ default_text = text })
      end,
      desc = "Live Grep Selection",
      mode = "v",
    },
    { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
    {
      "<leader>sD",
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
    pickers = {
      buffers = {
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
          },
        },
      },
    },
    defaults = {
      layout_strategy = "flex",
      layout_config = {
        flex = {
          width = 0.95,
        },
      },
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
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-o>"] = actions.select_tab,
          ["<C-g>"] = function(prompt_bufnr)
            -- Use nvim-window-picker to choose the window by dynamically attaching a function
            local action_set = require("telescope.actions.set")
            local action_state = require("telescope.actions.state")

            local picker = action_state.get_current_picker(prompt_bufnr)
            picker.get_selection_window = function(picker, _)
              local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
              -- Unbind after using so next instance of the picker acts normally
              picker.get_selection_window = nil
              return picked_window_id
            end

            return action_set.edit(prompt_bufnr, "edit")
          end,
          -- ["<CR>"] = actions.select_default,
          ["<CR>"] = multi_select_action,
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
          ["<CR>"] = multi_select_action,
        },
      },
      buffer_previewer_maker = function(filepath, bufnr, opts)
        opts = opts or {}

        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > 100000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end,
    },
  },
}

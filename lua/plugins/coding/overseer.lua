vim.api.nvim_create_user_command("WatchRun", function()
  local overseer = require("overseer")
  overseer.run_template({ name = "run" }, function(task)
    if task then
      task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
      local main_win = vim.api.nvim_get_current_win()
      overseer.run_action(task, "open vsplit")
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
    end
  end)
end, {})

return {
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>cow", "<cmd>WatchRun<CR>", desc = "Overseer Watch" },
      { "<leader>coa", "<cmd>OverseerTaskAction<cr>", desc = "Overseer Task Action" },
      { "<leader>cob", "<cmd>OverseerBuild<cr>", desc = "Overseer Build" },
      { "<leader>coc", "<cmd>OverseerClose<cr>", desc = "Overseer Close" },
      { "<leader>cod", "<cmd>OverseerDeleteBundle<cr>", desc = "Overseer Delete Bundle" },
      { "<leader>col", "<cmd>OverseerLoadBundle<cr>", desc = "Overseer Load Bundle" },
      { "<leader>cos", "<cmd>OverseerSaveBundle<cr>", desc = "Overseer Save Bundle" },
      { "<leader>coo", "<cmd>OverseerOpen<cr>", desc = "Overseer Open" },
      { "<leader>coq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
      { "<leader>cor", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
      { "<leader>coR", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
      { "<leader>cot", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle" },
    },
    opts = {
      component_aliases = {
        default_neotest = {
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_notify",
          "on_complete_dispose",
        },
      },
      templates = { "builtin", "user.run", "user.run_local", "user.bob" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>co"] = { name = "+Overseer" },
      },
    },
  },
}

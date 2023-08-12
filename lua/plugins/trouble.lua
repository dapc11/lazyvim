return {
  {
    "folke/trouble.nvim",
    keys = function()
      return {
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      }
    end,
  },
}

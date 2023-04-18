return {
  "anuvyklack/windows.nvim",
  event = "WinNew",
  dependencies = {
    { "anuvyklack/middleclass" },
  },
  keys = { { "<C-z>", "<cmd>WindowsMaximize<cr>", desc = "Zoom", mode = { "n", "t" } } },
  config = function()
    vim.o.winwidth = 5
    vim.o.equalalways = false
    require("windows").setup()
  end,
}

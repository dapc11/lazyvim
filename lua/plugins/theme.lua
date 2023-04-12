return {
  {
    "dapc11/github-nvim-theme",
    lazy = false,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
  },
}

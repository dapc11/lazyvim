return {
  {
    "dapc11/github-nvim-theme",
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
}

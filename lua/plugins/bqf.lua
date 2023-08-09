return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = {
    { "junegunn/fzf", build = "./install --bin" },
  },
  opts = {
    func_map = {
      fzffilter = "f",
      filter = "n",
      split = "s",
      vsplit = "v",
      ptoggleitem = "p",
    },
  },
  config = function(_, opts)
    require("bqf").setup(opts)
  end,
}

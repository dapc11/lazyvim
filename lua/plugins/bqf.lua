return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = {
    { "junegunn/fzf", build = "./install --bin" },
  },
  opts = {
    func_map = {
      fzffilter = "<C-f>",
      filter = "<C-n>",
      split = "<C-s>",
      vsplit = "<C-v>",
      ptoggleitem = "<C-p>",
    },
  },
  config = function(_, opts)
    require("bqf").setup(opts)
  end,
}

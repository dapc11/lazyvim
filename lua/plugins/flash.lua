return {
  { "ggandor/leap.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, require("flash").jump, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, require("flash").treesitter, desc = "Flash Treesitter" },
      { "r", mode = "o", require("flash").remote, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, require("flash").treesitter_search, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, require("flash").toggle, desc = "Toggle Flash Search" },
    },
  },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function()
    require("which-key").register({
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["ys"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>z"] = { name = "+zettelkasten" },
      ["<leader>sn"] = { name = "+noice" },
    })
  end,
}

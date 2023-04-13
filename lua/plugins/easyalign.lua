return {
  "junegunn/vim-easy-align",
  config = function()
    vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { desc = "Interactive Easy Align" })
  end,
}

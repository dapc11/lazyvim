local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  -- stylua: ignore
  ["<leader>cb"] = { "<cmd>:GoBuild<cr>", "Go Build", buffer = bufnr },
  ["<leader>ta"] = { "<cmd>:GoAddTest<cr>", "Add Tests", buffer = bufnr },
  ["<leader>tr"] = { "<cmd>:GoTest -n<cr>", "Test Nearest", buffer = bufnr },
  ["<leader>tf"] = { "<cmd>:GoTestFunc<cr>", "Run Tests for current Func", buffer = bufnr },
  ["<leader>tF"] = { "<cmd>:GoTestFile<cr>", "Run Tests for Current File", buffer = bufnr },
  ["<leader>tt"] = { "<cmd>:GoTest -f<cr>", "Test File", buffer = bufnr },
  ["<leader>tT"] = { "<cmd>:GoTest<cr>", "Test All", buffer = bufnr },
  ["<leader>tw"] = { "<cmd>:GoTestSum -w<cr>", "Test Watch Mode", buffer = bufnr },
})

local bufnr = vim.api.nvim_get_current_buf()
require("which-key").register({
  -- stylua: ignore
  ["<leader>cb"] = { "<cmd>:GoBuild<cr>", "Go Build", buffer = bufnr },
  ["<leader>cta"] = { "<cmd>:GoAddTest<cr>", "Add Tests", buffer = bufnr },
  ["<leader>ctr"] = { "<cmd>:GoTest -n<cr>", "Test Nearest", buffer = bufnr },
  ["<leader>ctf"] = { "<cmd>:GoTestFunc<cr>", "Run Tests for current Func", buffer = bufnr },
  ["<leader>ctF"] = { "<cmd>:GoTestFile<cr>", "Run Tests for Current File", buffer = bufnr },
  ["<leader>ctt"] = { "<cmd>:GoTest -f<cr>", "Test File", buffer = bufnr },
  ["<leader>ctT"] = { "<cmd>:GoTest<cr>", "Test All", buffer = bufnr },
  ["<leader>ctw"] = { "<cmd>:GoTestSum -w<cr>", "Test Watch Mode", buffer = bufnr },

  -- Debug
  -- ["<leader>cdc"] = { "<cmd>:GoDebug<cr>", "Continue", buffer = bufnr },
  -- ["<leader>cdt"] = { "<cmd>:GoDbgStop<cr>", "Terminate", buffer = bufnr },
  -- ["<leader>cdb"] = { "<cmd>:GoBreakToggle<cr>", "Toggle Breakpoint", buffer = bufnr },
})

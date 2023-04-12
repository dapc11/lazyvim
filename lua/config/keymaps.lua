-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- LSP
map("n", "]d", function()
  vim.diagnostic.goto_next({
    float = false,
  })
end, { desc = "Next Diagnostic" })
map("n", "[d", function()
  vim.diagnostic.goto_prev({
    float = false,
  })
end, { desc = "Previous Diagnostic" })

-- Unimapired
vim.cmd [[
nmap > [
nmap < ]
omap > [
omap < ]
xmap > [
xmap < ]
]]

-- git
map("n", "<leader>gg", vim.cmd.Git, { desc = "Git" })
map("n", "<C-g>", vim.cmd.Git, { desc = "Git" })

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
vim.cmd([[
nmap > [
nmap < ]
omap > [
omap < ]
xmap > [
xmap < ]
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
]])

-- git
map("n", "<leader>gg", vim.cmd.Git, { desc = "Git" })
map("n", "<C-g>", vim.cmd.Git, { desc = "Git" })

map("n", "<leader>s", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>v", "<C-W>v", { desc = "Split window right" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +8<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -8<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -8<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +8<cr>", { desc = "Increase window width" })
map({ "v", "n" }, "p", '"_dP')

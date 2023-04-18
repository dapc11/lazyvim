local map = vim.keymap.set

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

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = function()
        return require("lazyvim.util").has("nvim-cmp")
      end,
    },
    { "mfussenegger/nvim-jdtls" },
  },
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<C-e>", vim.diagnostic.open_float, mode = { "n", "i" }, desc = "Open diagnostic float" }
  end,
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = false,
      severity_sort = true,
    },
    autoformat = true,
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    servers = {
      jsonls = {},
      dockerls = {},
      vimls = {},
      jdtls = {},
      helm_ls = {},
      gopls = {
        settings = {
          gopls = require("plugins.lsp_servers.gopls"),
        },
      },
      pyright = {
        settings = {
          python = require("plugins.lsp_servers.pyright"),
        },
      },
      lua_ls = {
        settings = {
          Lua = require("plugins.lsp_servers.luals"),
        },
      },
    },
    setup = {
      jdtls = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "java",
          callback = require("plugins.lsp_servers.jdtls").Jdtls,
        })
      end,
    },
  },
}

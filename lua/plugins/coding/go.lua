return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gomod", "go", "gowork", "gosum" })
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          runner = "testify",
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-json", "-timeout=60s" },
        },
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
    opts = {
      disable_defaults = false,
      go = "go",
      gofmt = "gofmt",
      max_line_len = 100,
      comment_placeholder = "",
      icons = { breakpoint = "", currentpos = "" },
      lsp_cfg = {
        settings = {
          gopls = {
            gofumpt = false,
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            diagnosticsDelay = "300ms",
            symbolMatcher = "fuzzy",
            completeUnimported = true,
            staticcheck = false,
            matcher = "Fuzzy",
            usePlaceholders = true,
            analyses = {
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedwrite = true,
            },
          },
        },
      },
      lsp_keymaps = false,
      sign_priority = 5,
      test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
      luasnip = true,
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = 'lua require("go.install").update_all_sync()',
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("null-ls")
        vim.list_extend(opts.sources, {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
          nls.builtins.formatting.gofumpt,
          nls.builtins.formatting.goimports_reviser,
        })
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "delve")
        end,
      },
    },
  },
}
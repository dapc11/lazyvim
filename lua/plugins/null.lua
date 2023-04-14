return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(
        ".null-ls-root",
        ".neoconf.json",
        "Makefile",
        ".git",
        "ruleset2.0.yaml",
        "pom.xml",
        "README.md"
      ),
      sources = {
        nls.builtins.code_actions.gitsigns,
        nls.builtins.diagnostics.trail_space.with({
          filetypes = {
            "lua",
            "go",
            "python",
            "java",
            "markdown",
            "sh",
          },
        }),
        -- Lua
        nls.builtins.formatting.stylua,
        -- Go
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofmt,
        -- Python
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort.with({ extra_args = { "--profile", "black" } }),
        nls.builtins.diagnostics.pylint.with({
          extra_args = {
            "--disable=R0801,W1508,C0114,C0115,C0116,C0301,W0611,W1309,C0103,W0201,E0401",
          },
          diagnostics_postprocess = function(diagnostic)
            diagnostic.code = diagnostic.message_id
          end,
        }),
        nls.builtins.diagnostics.flake8.with({
          extra_args = {
            "--extend-ignore=E302,E501,D107,D105,W503,E203,D100,D103,F401",
          },
        }),
      },
    }
  end,
}

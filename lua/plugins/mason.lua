return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "flake8",
      "black",
      "isort",
      "pylint",
      "goimports",
      "golangci-lint",
    },
  },
}

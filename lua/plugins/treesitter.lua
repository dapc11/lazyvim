local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- :TSInstallFromGrammar gotmpl
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml", "tpl", "yml" },
}
vim.filetype.add({
  extension = {
    tpl = "gotmpl",
  },
  pattern = {
    [".*/templates/.*tpl"] = "gotmpl",
    [".*/templates/.*yaml"] = "gotmpl",
    [".*/templates/.*.yml"] = "gotmpl",
  },
})

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "java",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
  },
}

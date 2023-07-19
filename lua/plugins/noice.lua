return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      enabled = false, -- enables the Noice cmdline UI
    },
    messages = {
      enabled = false, -- enables the Noice messages UI
    },
    popupmenu = {
      enabled = false, -- enables the Noice popupmenu UI
    },
    notify = {
      enabled = true,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
  },
}

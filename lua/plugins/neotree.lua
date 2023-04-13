return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    enable_diagnostics = false,
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["h"] = "open_split",
        ["v"] = "open_vsplit",
        ["s"] = "none",
        ["S"] = "none",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
}

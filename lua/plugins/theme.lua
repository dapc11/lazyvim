return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(colors)
        colors.bg = "#24292e"
        colors.bg_sidebar = "#282c34"
        colors.bg_float = "#24292e"
        colors.git.change = "#7aa2f7"
        colors.git.add = "#98c379"
        colors.git.delete = "#e06c75"
        colors.red = "#e06c75"
      end,
      on_highlights = function(highlights, colors)
        -- highlights.WinSeparator = { bg = colors.none, fg = colors.blue7 }
        highlights.WinSeparator = { bg = colors.none, fg = colors.none }
        highlights.FloatBorder = { bg = colors.bg, fg = colors.blue7 }
        highlights.TelescopeBorder = { bg = colors.bg, fg = colors.blue7 }
        highlights.NeogitDiffAdd = { fg = colors.green }
        highlights.NeogitDiffDelete = { fg = colors.red }
        highlights.NeogitDiffContextHighlight = { fg = colors.fg }
        highlights.NeogitHunkHeaderHighlight = { fg = colors.fg, bold = true }
        highlights.NeogitHunkHeader = { fg = colors.blue, bold = true }
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.BqfPreviewFloat = { bg = colors.bg }
        highlights.Directory = { bold = true }
        highlights.NvimTreeFileDirty = { fg = colors.git.change, bold = true }
        highlights.NvimTreeGitDirty = { fg = colors.git.change, bold = true }
      end,
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "*",
        "lua",
        "!lazy",
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        mode = "virtualtext",
        virtualtext = "■■■■■",
      },
    },
  },
}

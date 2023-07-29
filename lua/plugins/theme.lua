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
        highlights.WinSeparator = { bg = colors.none, fg = colors.blue7 }
        highlights.NeoTreeWinSeparator = { bg = colors.none, fg = colors.bg_sidebar }
        highlights.NeoTreeStatusLineNC = { bg = colors.bg_sidebar, fg = colors.none }
        highlights.NeoTreeStatusLine = { bg = colors.bg_sidebar, fg = colors.bg_sidebar }
        highlights.FloatBorder = { bg = colors.bg, fg = colors.blue7 }
        highlights.TelescopeBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar }
        highlights.TelescopePromptBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar }
        highlights.TelescopePromptTitle = { bg = colors.bg_sidebar }
        highlights.TelescopePromptNormal = { bg = colors.bg_sidebar }
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
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local custom_theme = require("lualine.themes.auto")
      local colors = require("tokyonight.colors").setup()

      custom_theme.normal = {
        a = { bg = colors.blue, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.blue },
        c = { bg = colors.bg_sidebar, fg = colors.fg_sidebar },
      }

      custom_theme.insert = {
        a = { bg = colors.green, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.green },
      }

      custom_theme.command = {
        a = { bg = colors.yellow, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.yellow },
      }

      custom_theme.visual = {
        a = { bg = colors.magenta, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.magenta },
      }

      custom_theme.replace = {
        a = { bg = colors.red, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.red },
      }

      custom_theme.terminal = {
        a = { bg = colors.green1, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.green1 },
      }

      custom_theme.inactive = {
        a = { bg = colors.bg_sidebar, fg = colors.blue },
        b = { bg = colors.bg_sidebar, fg = colors.fg_gutter, gui = "bold" },
        c = { bg = colors.bg_sidebar, fg = colors.fg_gutter },
      }

      local neotree = { sections = {}, filetypes = { "neo-tree" } }
      return {
        options = {
          theme = custom_theme,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        extensions = { "trouble", "nvim-dap-ui", "overseer", neotree, "lazy" },
      }
    end,
  },
}

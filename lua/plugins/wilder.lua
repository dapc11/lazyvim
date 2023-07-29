return {
  {
    "gelguy/wilder.nvim",
    build = ":UpdateRemotePlugins",
    dependencies = { "romgrk/fzy-lua-native", "folke/tokyonight.nvim" },
    config = function()
      local wilder = require("wilder")

      wilder.setup({ modes = { ":" } })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = { "rg", "--files" },
            dir_command = { "fd", "-td" },
            filters = { "fuzzy_filter" },
          }),
          wilder.cmdline_pipeline({
            fuzzy = 2,
            fuzzy_filter = wilder.lua_fzy_filter(),
          })
        ),
      })

      local tokyonight = require("tokyonight.colors")
      local colors = tokyonight.setup()
      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
            left = { wilder.popupmenu_devicons() },
            highlighter = wilder.lua_fzy_highlighter(),
            highlights = {
              default = wilder.make_hl(
                "WilderPmenu",
                "Pmenu",
                { { a = 1 }, { a = 1 }, { foreground = colors.fg, background = colors.bg } }
              ),
              accent = wilder.make_hl(
                "WilderAccent",
                "Pmenu",
                { { a = 1 }, { a = 1 }, { foreground = colors.blue, bold = 1 } }
              ),
              selected = wilder.make_hl(
                "WilderAccent",
                "Pmenu",
                { { a = 1 }, { a = 1 }, { foreground = colors.blue, background = colors.bg_sidebar, bold = 1 } }
              ),
            },
          })),
        })
      )
    end,
  },
}

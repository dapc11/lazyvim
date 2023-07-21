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
            file_command = function(_, arg)
              if string.find(arg, "%.") ~= nil then
                return { "fd", "-tf", "-H" }
              else
                return { "fd", "-tf" }
              end
            end,
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
      local highlights = {
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
      }
      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
            left = { wilder.popupmenu_devicons() },
            highlighter = {
              wilder.pcre2_highlighter(),
              wilder.lua_fzy_highlighter(),
            },
            -- stylua: ignore
            highlights = highlights,
          })),
        })
      )
    end,
  },
}

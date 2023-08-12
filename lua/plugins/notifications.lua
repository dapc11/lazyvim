return {
  {
    "rcarriga/nvim-notify",
    opts = {
      max_height = 1,
      render = "compact",
      stages = "static",
      timeout = 1000,
    },
    keys = function()
      return {
        {
          "<C-x>",
          function()
            require("notify").dismiss({ silent = true, pending = true })
          end,
          desc = "Dismiss all Notifications",
        },
      }
    end,
  },
}

return {
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "minimal",
    },
    keys = {
      {
        "<C-x>",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
  },
}

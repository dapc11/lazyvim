return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>cdu", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>cde", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>cd"] = { name = "+debug" },
          ["<leader>cda"] = { name = "+adapters" },
        },
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {},
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>cdB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>cdb", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>cdc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>cdC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>cdg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>cdi", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>cdj", function() require("dap").down() end, desc = "Down" },
    { "<leader>cdk", function() require("dap").up() end, desc = "Up" },
    { "<leader>cdl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>cdo", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>cdO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>cdp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>cdr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>cds", function() require("dap").session() end, desc = "Session" },
    { "<leader>cdt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>cdw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}

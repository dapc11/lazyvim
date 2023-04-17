return {
  "mfussenegger/nvim-dap",

  dependencies = {
    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" }
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
      {
        "mfussenegger/nvim-dap-python",
        keys = {
          {
            "<leader>dap",
            function()
              require("dap-python").test_method()
            end,
            desc = "Debug Python Method",
          },
          {
            "<leader>daP",
            function()
              require("dap-python").test_class()
            end,
            desc = "Debug Python Class",
          },
        },

        config = function(_, opts)
          require("dap-python").setup("/usr/bin/python3")
          require("dap-python").test_runner = "pytest"
          local dap = require("dap")
          local venv = os.getenv("VIRTUAL_ENV")
          local python_executable = venv .. "/bin/python"
          dap.adapters.python = {
            type = "executable",
            command = python_executable,
            args = { "-m", "debugpy.adapter" },
          }
        end,
      },
      {
        "leoluz/nvim-dap-go",
        keys = {
          {
            "<leader>dag",
            function()
              require("dap-go").debug_test()
            end,
            desc = "Debug Go Method",
          },
        },
        config = function(_, opts)
          local dap = require("dap")
          dap.configurations.go = {
            {
              type = "go",
              name = "Debug",
              request = "launch",
              program = "${file}",
            },
            {
              type = "go",
              name = "Debug test", -- configuration for debugging test files
              request = "launch",
              mode = "test",
              program = "${file}",
            },
            -- works with go.mod packages and sub packages
            {
              type = "go",
              name = "Debug test (go.mod)",
              request = "launch",
              mode = "test",
              program = "./${relativeFileDirname}",
            },
          }
          dap.adapters.go = function(callback, config)
            local stdout = vim.loop.new_pipe(false)
            local handle
            local pid_or_err
            local port = 38697
            local opts = {
              stdio = { nil, stdout },
              args = { "dap", "-l", "127.0.0.1:" .. port },
              detached = true,
            }
            handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
              stdout:close()
              handle:close()
              if code ~= 0 then
                print("dlv exited with code", code)
              end
            end)
            assert(handle, "Error running dlv: " .. tostring(pid_or_err))
            stdout:read_start(function(err, chunk)
              assert(not err, err)
              if chunk then
                vim.schedule(function()
                  require("dap.repl").append(chunk)
                end)
              end
            end)
            -- Wait for delve to start
            vim.defer_fn(function()
              callback({ type = "server", host = "127.0.0.1", port = port })
            end, 100)
          end
        end,
      },
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<leader>dr", function() require("dap").repl.open() end, desc = "Repl" },
  },

  config = function()
    local Config = require("lazyvim.config")
    local dap = require("dap")
    dap.defaults.fallback.external_terminal = {
      command = "wezterm",
      args = { "-e" },
    }
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    require("dap.repl").commands = vim.tbl_extend("force", require("dap.repl").commands, {
      continue = { ".continue", "c" },
      next_ = { ".next", "n" },
      into = { ".into", "s" },
      into_targets = { "st" },
      out = { ".out", "r" },
      scopes = { ".scopes", "a" },
      threads = { ".threads", "t", "threads" },
      frames = { ".frames", "f", "bt" },
      exit = { "exit", ".exit", "q" },
      up = { ".up", "up" },
      down = { ".down", "down" },
      goto_ = { ".goto", "j" },
      capabilities = { ".capabilities", ".ca" },
      custom_commands = {
        [".echo"] = function(text)
          dap.repl.append(text)
        end,
      },
    })
    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}

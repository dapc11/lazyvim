-- TODO: Fix keybinds
local M = {}
function M.Jdtls()
  -- Install Java, this file is assuming that Sdkman is used as follows:
  -- curl -s "https://get.sdkman.io" | bash
  -- sdk install java 17.0.4-oracle
  -- sdk install java 11.0.11-open
  -- sdk install java 8.0.302-open
  -- sdk install maven 3.8.6

  -- Determine OS
  local home = os.getenv("HOME")
  if vim.fn.has("mac") == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "mac"
  elseif vim.fn.has("unix") == 1 then
    WORKSPACE_PATH = home .. "/workspace/"
    CONFIG = "linux"
  else
    print("Unsupported system")
  end
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

  local workspace_dir = WORKSPACE_PATH .. project_name

  local status, jdtls = pcall(require, "jdtls")
  if not status then
    print("Failed to load jdtls.")
    return
  end

  -- Find root of project
  local root_markers = { ".git", "ruleset2.0.yaml" }
  local root_dir = require("jdtls.setup").find_root(root_markers)
  if root_dir == "" then
    return
  end

  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  local bundles = {}

  local config = {
    cmd = {
      os.getenv("HOME") .. "/.sdkman/candidates/java/17.0.4-oracle/bin/java", -- or '/path/to/java17_or_newer/bin/java'
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
      "-configuration",
      home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. CONFIG,
      "-data",
      workspace_dir,
    },
    root_dir = root_dir,
    init_options = {
      bundles = bundles,
    },
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = "all", -- literals, all, none
          },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
        },
        useBlocks = true,
        signatureHelp = { enabled = true },
        configuration = {
          updateBuildConfiguration = "interactive",
          -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          -- And search for `interface RuntimeOption`
          -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
          runtimes = {
            {
              name = "JavaSE-11",
              path = os.getenv("HOME") .. "/.sdkman/candidates/java/11.0.11-open/",
            },
            {
              name = "JavaSE-1.8",
              path = os.getenv("HOME") .. "/.sdkman/candidates/java/8.0.302-open/",
            },
            {
              name = "JavaSE-17",
              path = os.getenv("HOME") .. "/.sdkman/candidates/java/17.0.4-oracle/",
            },
          },
        },
      },
    },
  }

  config["on_attach"] = function(_, bufnr)
    vim.set.keymap(
      "n",
      "<leader>Co",
      jdtls.organize_imports,
      { buffer = bufnr, desc = "Organize Imports", silent = true }
    )
    vim.set.keymap(
      "n",
      "<leader>Cv",
      jdtls.extract_variable,
      { buffer = bufnr, desc = "Extract Variable", silent = true }
    )
    vim.set.keymap(
      "n",
      "<leader>Cc",
      jdtls.extract_constant,
      { buffer = bufnr, desc = "Extract Constant", silent = true }
    )
    vim.set.keymap(
      "n",
      "<leader>Ct",
      jdtls.test_nearest_method,
      { buffer = bufnr, desc = "Test Method", silent = true }
    )
    vim.set.keymap("n", "<leader>CT", jdtls.test_class, { buffer = bufnr, desc = "Test Class", silent = true })
    vim.set.keymap("v", "<leader>Cv", function()
      jdtls.extract_variable(true)
    end, { buffer = bufnr, desc = "Extract Variable", silent = true })
    vim.set.keymap("v", "<leader>Cc", function()
      jdtls.extract_constant(true)
    end, { buffer = bufnr, desc = "Extract Constant", silent = true })
    vim.set.keymap("v", "<leader>Cm", function()
      jdtls.extract_method(true)
    end, { buffer = bufnr, desc = "Extract Method", silent = true })
    vim.set.keymap(
      "n",
      "<leader>Cu",
      vim.cmd.JdtUpdateConfig,
      { buffer = bufnr, desc = "Update Config", silent = true }
    )
  end

  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
  )
  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
  )
  vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
  vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
      local _, _ = pcall(vim.lsp.codelens.refresh)
    end,
  })

  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  jdtls.start_or_attach(config)
  return true
end

return M

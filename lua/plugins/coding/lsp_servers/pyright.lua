return {
  analysis = {
    diagnosticSeverityOverrides = {
      reportOptionalMemberAccess = "none",
      reportMissingImports = "none",
    },
    autoImportCompletions = true,
    typeCheckingMode = "off",
    autoSearchPaths = true,
    useLibraryCodeForTypes = true,
    diagnosticMode = "openFilesOnly",
  },
  venvPath = "~/.virtualenvs/",
  pythonPath = "python3",
}

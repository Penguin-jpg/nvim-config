return {
  before_init = function(_, c)
    if not c.settings then c.settings = {} end
    if not c.settings.python then c.settings.python = {} end
    c.settings.python.pythonPath = vim.fn.exepath "python"
  end,
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
          pytestParameters = true,
        },
        diagnosticSeverityOverrides = {
          reportUnusedImport = "information",
          reportUnusedFunction = "information",
          reportUnusedVariable = "information",
          reportGeneralTypeIssues = "none",
          reportOptionalMemberAccess = "none",
          reportOptionalSubscript = "none",
          reportPrivateImportUsage = "none",
        },
      },
    },
  },
}

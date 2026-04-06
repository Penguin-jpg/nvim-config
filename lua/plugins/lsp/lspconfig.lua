local get_icon = require("utils.ui").get_icon

return {
  "neovim/nvim-lspconfig",
  event = "User File",
  cmd = vim.fn.exists ":lsp" ~= 2 and { "LspInfo", "LspLog", "LspStart" } or nil,
  config = function()
    -- options for vim.diagnostic.config()
    local diagnostics_opts = {
      underline = true,
      update_in_insert = false,
      virtaul_text = false, -- use tiny-inline-diagnostic instead
      virtual_lines = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = get_icon("DiagnosticError", 1),
          [vim.diagnostic.severity.WARN] = get_icon("DiagnosticWarn", 1),
          [vim.diagnostic.severity.HINT] = get_icon("DiagnosticHint", 1),
          [vim.diagnostic.severity.INFO] = get_icon("DiagnosticInfo", 1),
        },
      },
    }
    -- config diagnostic
    vim.diagnostic.config(vim.deepcopy(diagnostics_opts))
  end,
}

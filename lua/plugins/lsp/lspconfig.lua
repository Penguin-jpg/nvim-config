local get_icon = require("utils.ui").get_icon

return {
  "neovim/nvim-lspconfig",
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  event = "User File",
  cmd = vim.fn.exists ":lsp" ~= 2 and { "LspInfo", "LspLog", "LspStart" } or nil,
  config = function()
    -- LSP-related autocmds
    local create_autocmd = vim.api.nvim_create_autocmd
    local create_augroup = vim.api.nvim_create_augroup
    create_autocmd("LspAttach", {
      desc = "Set mappings and featuers when LSP attaches",
      group = create_augroup("on_lsp_attach", { clear = true }),
      callback = function(event)
        local set_map = vim.keymap.set
        set_map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto definition" })
        set_map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Goto declaration" })
        set_map("n", "gr", function() vim.lsp.buf.references() end, { desc = "Goto references" })
        set_map("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Goto implementation" })
        set_map("n", "gt", function() vim.lsp.buf.type_definition() end, { desc = "Goto type definition" })
        set_map("n", "gh", function() vim.lsp.buf.hover() end, { desc = "Hover documentation" })
        set_map("n", "gH", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
        set_map({ "n", "x" }, "<Leader>la", function() vim.lsp.buf.code_action() end, { desc = "LSP code action" })
        set_map("n", "<Leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename current symbol" })

        -- document highlighting
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight", event.buf) then
          local highlight = create_augroup("lsp_highlight", { clear = false })
          create_autocmd({ "CursorHold", "CursorHoldI" }, {
            desc = "Document highlight",
            group = highlight,
            buffer = event.buf,
            callback = function() vim.lsp.buf.document_highlight() end,
          })
          create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            desc = "Clear document highlight when cursor moves",
            group = highlight,
            buffer = event.buf,
            callback = function() vim.lsp.buf.clear_references() end,
          })
          create_autocmd("LspDetach", {
            desc = "Clear document highlight when lsp detaches",
            group = create_augroup("on_lsp_detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = "lsp_highlight", buffer = event2.buf }
            end,
          })
        end
        -- inlay hints
        if client and client:supports_method("textDocument/inlayHint", event.buf) then
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
        -- semantic tokens
        if client and client:supports_method "textDocument/semanticTokens/full" then
          vim.lsp.semantic_tokens.enable(true, { bufnr = event.buf })
        end
      end,
    })

    -- diagnostics
    local diagnostics_opts = {
      underline = true,
      update_in_insert = false,
      virtual_text = false, -- use tiny-inline-diagnostic instead
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
    vim.diagnostic.config(vim.deepcopy(diagnostics_opts))

    -- setup servers
    vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })
    -- we don't need to use vim.lsp.config on every server since nvim-lspconfig provides default config for them
    -- configs at after/lsp/*.lua will be merged automatically
    vim.lsp.enable {
      "lua_ls",
      "clangd",
      "ty",
      "ruff",
    }
  end,
}

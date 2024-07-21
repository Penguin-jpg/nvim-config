return {
  n = {
    ["<Leader>la"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
      cond = "textDocument/codeAction",
    },
    ["<Leader>lr"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
      cond = "textDocument/rename",
    },
    ["<Leader>lR"] = {
      function() vim.lsp.buf.references() end,
      desc = "Search references",
      cond = "textDocument/references",
    },
    ["gd"] = {
      function() vim.lsp.buf.definition() end,
      desc = "Show the definition of current symbol",
      cond = "textDocument/definition",
    },
    ["gD"] = {
      function() vim.lsp.buf.declaration() end,
      desc = "Declaration of current symbol",
      cond = "textDocument/declaration",
    },
    ["gr"] = {
      function() vim.lsp.buf.references() end,
      desc = "Reference of current symbol",
      cond = "textDocument/references",
    },
    ["gh"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details", cond = "textDocument/hover" },
    ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
    ["gi"] = {
      function() vim.lsp.buf.implementation() end,
      desc = "Implementation of current symbol",
      cond = "textDocument/implementation",
    },
    ["gt"] = {
      function() vim.lsp.buf.type_definition() end,
      desc = "Definition of current type",
      cond = "textDocument/typeDefinition",
    },
    ["gs"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
      cond = "textDocument/signatureHelp",
    },
    ["<Leader>uh"] = {
      function() require("astrolsp.toggles").buffer_inlay_hints() end,
      desc = "Toggle LSP inlay hints (buffer)",
      cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
    },
    ["<Leader>uH"] = {
      function() require("astrolsp.toggles").inlay_hints() end,
      desc = "Toggle LSP inlay hints (global)",
      cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
    },
    ["<Leader>uY"] = {
      function() require("astrolsp.toggles").buffer_semantic_tokens() end,
      desc = "Toggle LSP semantic highlight (buffer)",
      cond = function(client)
        return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens
      end,
    },
  },
  x = {
    ["<Leader>la"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
      cond = "textDocument/codeAction",
    },
  },
}

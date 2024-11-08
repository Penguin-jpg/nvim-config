return {
  "AstroNvim/astrolsp",
  lazy = true,
  opts = {
    -- configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = true, -- enable/disable automatic signature help popup globally on startup
    },
    capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
      textDocument = {
        completion = {
          completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
          },
        },
        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
      },
    }),
    -- use conform.nvim for formatting
    formatting = { disabled = true },
    -- enable servers that you already have installed without mason
    servers = {},
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      lua_ls = require "plugins.lsp.configs.lua_ls",
      clangd = require "plugins.lsp.configs.clangd",
      basedpyright = require "plugins.lsp.configs.basedpyright",
      ruff = require "plugins.lsp.configs.ruff",
    },
    handlers = {
      -- customize how language servers are attached
      function(server, server_opts) require("lspconfig")[server].setup(server_opts) end,
    },
    lsp_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded", silent = true, focusable = false }
      ),
    },
    -- configure buffer local user commands to add when attaching a language server
    commands = {},
    -- configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
      lsp_auto_signature_help = {
        cond = "textDocument/signatureHelp",
        {
          event = "TextChangedI",
          desc = "Automatically show signature help if enabled",
          callback = function(args)
            local signature_help = vim.b[args.buf].signature_help
            if signature_help == nil then signature_help = require("astrolsp").config.features.signature_help end
            if signature_help then
              local trigger = vim.b[args.buf].signature_help_triggerCharacters or {}
              local retrigger = vim.b[args.buf].signature_help_retriggerCharacters or {}
              local pos = vim.api.nvim_win_get_cursor(0)[2]
              local cur_char = vim.api.nvim_get_current_line():sub(pos, pos)
              if
                vim.g.signature_help_triggered and (cur_char:match "%s" or retrigger[cur_char])
                or trigger[cur_char]
              then
                vim.g.signature_help_triggered = true
                vim.lsp.buf.signature_help()
                return
              end
            end
            vim.g.signature_help_triggered = false
          end,
        },
        {
          event = "InsertLeave",
          desc = "Clear automatic signature help internals when leaving insert",
          callback = function() vim.g.signature_help_triggered = false end,
        },
      },
      disable_inlay_hints_on_insert = {
        -- only create for language servers that support inlay hints
        -- (and only if vim.lsp.inlay_hint is available)
        cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        {
          -- when going into insert mode
          event = "InsertEnter",
          desc = "disable inlay hints on insert",
          callback = function(args)
            local filter = { bufnr = args.buf }
            -- if the inlay hints are currently enabled
            if vim.lsp.inlay_hint.is_enabled(filter) then
              -- disable the inlay hints
              vim.lsp.inlay_hint.enable(false, filter)
              -- create a single use autocommand to turn the inlay hints back on
              -- when leaving insert mode
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.lsp.inlay_hint.enable(true, filter) end,
              })
            end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
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
        ["<Leader>ti"] = {
          function() require("astrolsp.toggles").inlay_hints() end,
          desc = "Toggle LSP inlay hints",
          cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        },
        ["<Leader>ts"] = {
          function() require("astrolsp.toggles").signature_help() end,
          desc = "Toggle automatic signature help",
          cond = "textDocument/signatureHelp",
        },
        ["<Leader>tt"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight",
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
    },
  },
}

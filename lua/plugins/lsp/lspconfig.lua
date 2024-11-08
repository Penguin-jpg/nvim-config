return {
  "neovim/nvim-lspconfig",
  event = "User File",
  dependencies = {
    { "AstroNvim/astrolsp", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
      dependencies = { "williamboman/mason.nvim" },
      cmd = { "LspInstall", "LspUninstall" },
      opts_extend = { "ensure_installed" },
      opts = {
        ensure_installed = {},
        -- use AstroLSP setup for mason-lspconfig
        handlers = { function(server) require("astrolsp").lsp_setup(server) end },
      },
      config = function(_, opts) require("mason-lspconfig").setup(opts) end,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      cmd = {
        "MasonToolsInstall",
        "MasonToolsInstallSync",
        "MasonToolsUpdate",
        "MasonToolsUpdateSync",
        "MasonToolsClean",
      },
      opts = {
        ensure_installed = {
          -- lua
          "lua-language-server",
          "stylua",
          "selene",
          -- c/cpp
          "clangd",
          "clang-format",
          "codelldb",
          -- python
          "ruff",
          "basedpyright",
          "debugpy",
          -- json
          "json-lsp",
          -- markdown
          "marksman",
          "prettierd",
        },
      },
      config = function(_, opts)
        local mason_tool_installer = require "mason-tool-installer"
        mason_tool_installer.setup(opts)
        if opts.run_on_start ~= false then mason_tool_installer.run_on_start() end
      end,
    },
  },
  config = function()
    -- define diagnostic signs
    local get_icon = require("utils.ui").get_icon
    local signs = {
      Error = get_icon("DiagnosticError", 1),
      Warn = get_icon("DiagnosticWarn", 1),
      Hint = get_icon("DiagnosticHint", 1),
      Info = get_icon("DiagnosticInfo", 1),
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- set up servers configured with AstroLSP
    vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
  end,
}

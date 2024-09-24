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
        -- use AstroLSP setup for mason-lspconfig
        ensure_installed = {},
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
    -- set up servers configured with AstroLSP
    vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
  end,
}

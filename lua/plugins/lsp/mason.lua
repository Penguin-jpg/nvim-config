return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    opts = function(_, opts)
      opts.ensure_installed = {
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
        "black",
        -- json
        "json-lsp",
        -- markdown
        "marksman",
        "prettierd",
      }
    end,
  },
}

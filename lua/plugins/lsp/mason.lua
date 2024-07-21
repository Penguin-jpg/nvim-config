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
    "williamboman/mason-lspconfig.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua_ls",
        "clangd",
        "basedpyright",
        "ruff",
      }
    end,
  },
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   -- add this to lazy load dap-related plugins
  --   init = function() end,
  --   -- overrides `require("mason-nvim-dap").setup(...)`
  --   opts = function(_, opts)
  --     -- add more things to the ensure_installed table protecting against community packs modifying it
  --     opts.ensure_installed = {
  --       "codelldb",
  --       "python",
  --     }
  --   end,
  -- },
}

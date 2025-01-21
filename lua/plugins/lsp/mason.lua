return {
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
  config = function(_, opts) require("mason").setup(opts) end,
}

return {
  "mason-org/mason.nvim",
  version = "^1",
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  opts_extend = { "registries" },
  opts = function(_, opts)
    if not opts.registries then opts.registries = {} end
    table.insert(opts.registries, "github:mason-org/mason-registry")
    if not opts.ui then opts.ui = {} end
    opts.ui = {
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },
    }
  end,
}

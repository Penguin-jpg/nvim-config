return {
  "mason-org/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
  dependencies = { "mason-org/mason.nvim" },
  event = "User File",
  cmd = { "LspInstall", "LspUninstall" },
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {},
  },
  config = function(_, opts)
    if require("utils.plugins").is_available "mason-tool-installer.nvim" then opts.ensure_installed = nil end
    require("mason-lspconfig").setup(opts)
  end,
}

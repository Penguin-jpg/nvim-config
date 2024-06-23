-- Plugins to add additional functionality for LSP
return {
  -- Signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "User AstroFile",
    config = function()
      require("lsp_signature").setup { bind = true, handler_opts = { border = "rounded" }, hint_enable = false }
    end,
  },
  -- Additional features for Clangd
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    ft = { "c", "cpp" },
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          clangd_extensions = {
            {
              event = "LspAttach",
              desc = "Load clangd_extensions with clangd",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                  require "clangd_extensions"
                  vim.api.nvim_del_augroup_by_name "clangd_extensions"
                end
              end,
            },
          },
        },
      },
    },
  },
}

-- Plugins to add additional functionality for LSP
return {
  -- Signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "User AstroFile",
    config = function() require("lsp_signature").setup() end,
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
  -- Python import module highlight
  {
    "wookayin/semshi", -- maintained fork
    build = ":UpdateRemotePlugins",
    ft = "python",
    init = function()
      -- better done by LSP
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
      vim.g["semshi#update_delay_factor"] = 0.001

      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        callback = function()
          vim.cmd [[
  				highlight! semshiGlobal gui=italic
  				highlight! link semshiImported @lsp.type.namespace
  				highlight! link semshiParameter @lsp.type.parameter
  				highlight! link semshiParameterUnused DiagnosticUnnecessary
  				highlight! link semshiBuiltin @function.builtin
  				highlight! link semshiAttribute @field
  				highlight! link semshiSelf @lsp.type.selfKeyword
  				highlight! link semshiUnresolved @lsp.type.unresolvedReference
  				highlight! link semshiFree @comment
  			]]
        end,
      })
    end,
  },
}

return {
    "neovim/nvim-lspconfig",
    event = require("utils.lazy").LazyFile,
    dependencies = {
      { "AstroNvim/astrolsp", opts = {} },
      {
        "williamboman/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
        dependencies = { "williamboman/mason.nvim" },
        opts = function()
          return {
            -- use AstroLSP setup for mason-lspconfig
            handlers = { function(server) require("astrolsp").lsp_setup(server) end },
          }
        end,
      },
      { "folke/neodev.nvim", lazy = true, opts = {} },
    },
    config = function()
      -- set up servers configured with AstroLSP
      vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
    end,
}

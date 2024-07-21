return {
  "stevearc/conform.nvim",
  event = require("utils.lazy").LazyFile,
  specs = {
    { "AstroNvim/astrolsp", optional = true, opts = { formatting = { disabled = true } } },
  },
  keys = {
    {
      "<leader>f",
      function() require("conform").format { async = true, lsp_fallback = true } end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    default_format_opts = { lsp = "fallback" },
    format_on_save = function(bufnr)
      if vim.g.autoformat == nil then vim.g.autoformat = true end
      local autoformat = vim.b[bufnr].autoformat
      if autoformat == nil then autoformat = vim.g.autoformat end
      if autoformat then return { timeout_ms = 500 } end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "black" },
      json = { "prettier" },
      markdown = { { "prettierd", "prettier" } },
    },
  },
}

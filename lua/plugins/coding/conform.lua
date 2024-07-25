return {
  "stevearc/conform.nvim",
  event = require("utils.lazy").LazyFile,
  keys = {
    {
      "<leader>lf",
      function() require("conform").format { async = true, lsp_fallback = true } end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<Leader>tf",
      function()
        if vim.b.autoformat == nil then
          if vim.g.autoformat == nil then vim.g.autoformat = true end
          vim.b.autoformat = vim.g.autoformat
        end
        vim.b.autoformat = not vim.b.autoformat
      end,
      desc = "Toggle autoformatting (buffer)",
    },
    {
      "<Leader>tF",
      function()
        if vim.g.autoformat == nil then vim.g.autoformat = true end
        vim.g.autoformat = not vim.g.autoformat
        vim.b.autoformat = nil
      end,
      desc = "Toggle autoformatting (global)",
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
      -- python = { "black" },
      python = { "black" },
      json = { "prettier" },
      markdown = { { "prettierd", "prettier" } },
    },
  },
}

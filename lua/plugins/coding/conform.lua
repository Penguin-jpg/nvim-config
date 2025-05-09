return {
  "stevearc/conform.nvim",
  lazy = true,
  dependencies = { "williamboman/mason.nvim" },
  event = "BufWritePre",
  cmd = "ConformInfo",
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
        if vim.g.autoformat == nil then vim.g.autoformat = true end
        vim.g.autoformat = not vim.g.autoformat
        vim.b.autoformat = nil
        require("utils").notify(string.format("Formatting %s", require("utils").bool2str(vim.g.autoformat)))
      end,
      desc = "Toggle autoformatting",
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
      python = { "ruff_organize_imports", "ruff_format" },
      json = { "prettier" },
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}

-- Some commands that I want to execute in specific timing
vim.api.nvim_create_augroup("autocommands", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Disable auto insert comment header",
  group = "autocommands",
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Show diagnostics text when cursor hovers that line",
  group = "autocommands",
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
-- Some commands that I want to execute in specific timing
vim.api.nvim_create_augroup("auto_commands", { clear = true })
vim.api.nvim_create_augroup("restore_seesion", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Disable auto insert comment header",
  group = "auto_commands",
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Show diagnostics text when cursor hovers that line",
  group = "auto_commands",
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

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Restore previous directory session if neovim opened with no arguments",
  group = "restore_seesion",
  nested = true, -- trigger other autocommands as buffers open
  callback = function()
    -- Only load the session if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
      -- try to load a directory session using the current working directory
      require("resession").load(
        vim.fn.getcwd(),
        { dir = "dirsession", silence_errors = true }
      )
    end
  end
})

-- Some commands that I want to execute in specific timing
vim.api.nvim_create_augroup("auto-commands", { clear = true })

return {
  -- autcommands to be executed only once
  oncecmds = {
    -- each augroup contains a list of auto commands
    {
      event = "VimEnter",
      desc = "Automatically change cursor type to default setting",
      group = "oncecmds",
      command = "set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
    },
    {
      event = "VimEnter",
      desc = "Disable auto insert comment header",
      group = "oncecmds",
      command = "set formatoptions-=cro",
    },
    {
      event = "VimEnter",
      desc = "Allow cursor to move one more character after end of line",
      group = "oncecmds",
      command = "set ve+=onemore",
    },
  },
  diagnosticscmds = {
    {
      event = "User",
      pattern = "AstroFile",
      desc = "Show diagnostics text when cursor hovers that line",
      group = "diagnosticscmds",
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
    },
  },
}
-- Some commands that I want to execute in specific timing

return function(autocmds)
  -- autcommands to be executed only once
  autocmds.oncecmds = {
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
  }

  autocmds.diagnosticscmds = {
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
  }
  return autocmds
end
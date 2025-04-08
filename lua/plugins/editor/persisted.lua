return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  opts = {
    autoload = false,
    use_git_branch = true,
  },
  config = function(_, opts)
    local persisted = require "persisted"
    -- ensure the git branch feature still works when invoke neovim from a sub-directory
    persisted.branch = function()
      local branch = vim.fn.systemlist("git branch --show-current")[1]
      return vim.v.shell_error == 0 and branch or nil
    end
    persisted.setup(opts)
  end,
  keys = {
    { "<Leader>Sr", "<Cmd>SessionLoad<CR>", desc = "Restore session" },
    { "<Leader>Sl", "<Cmd>SessionLoadLast<CR>", desc = "Restore last session" },
    { "<Leader>Sc", "<Cmd>SessionSelect<CR>", desc = "Choose a session to load" },
    { "<Leader>Ss", "<Cmd>SessionSave<CR>", desc = "Save the current session" },
    { "<Leader>SS", "<Cmd>SessionStop<CR>", desc = "Don't save current session" },
  },
}

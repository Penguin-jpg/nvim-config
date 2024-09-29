return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<Leader>Sc", function() require("persistence").load() end, desc = "Restore session" },
    { "<Leader>Sl", function() require("persistence").load { last = true } end, desc = "Restore last session" },
    { "<Leader>Ss", function() require("persistence").select() end, desc = "Select a session to load" },
    { "<Leader>SS", function() require("persistence").stop() end, desc = "Don't save current session" },
  },
}

return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<Leader>sc", function() require("persistence").load() end, desc = "Restore session" },
    { "<Leader>sl", function() require("persistence").load { last = true } end, desc = "Restore last session" },
    { "<Leader>ss", function() require("persistence").select() end, desc = "Select a session to load" },
    { "<Leader>sS", function() require("persistence").stop() end, desc = "Don't save current session" },
  },
}

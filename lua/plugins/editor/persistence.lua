return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    branch = true, -- use git branch to save session
  },
  keys = {
    { "<Leader>Sl", function() require("persistence").load() end, desc = "Load session" },
    { "<Leader>Ss", function() require("persistence").select() end, desc = "Select session" },
    { "<Leader>SS", function() require("persistence").stop() end, desc = "Stop saving session" },
  },
}

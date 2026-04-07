return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<C-.>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "t", "i", "x" },
      desc = "Sidekick Focus",
    },
    {
      "<Leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick toggle CLI",
    },
    {
      "<Leader>as",
      function() require("sidekick.cli").select() end,
      desc = "Select CLI",
    },
    {
      "<Leader>ac",
      function() require("sidekick.cli").close() end,
      desc = "Close a CLI Session",
    },
    {
      "<Leader>at",
      function() require("sidekick.cli").send { msg = "{this}" } end,
      mode = { "x", "n" },
      desc = "Send this message to CLI",
    },
    {
      "<Leader>af",
      function() require("sidekick.cli").send { msg = "{file}" } end,
      desc = "Send this file to CLI",
    },
    {
      "<Leader>av",
      function() require("sidekick.cli").send { msg = "{selection}" } end,
      mode = { "x" },
      desc = "Send visual selection",
    },
    {
      "<Leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick select prompt",
    },
    {
      "<Leader>tn",
      function() require("sidekick.nes").toggle() end,
      mode = { "n" },
      desc = "Toggle NES",
    },
    {
      "<Leader>anu",
      function() require("sidekick.nes").update() end,
      mode = { "n" },
      desc = "Update NES",
    },
  },
}

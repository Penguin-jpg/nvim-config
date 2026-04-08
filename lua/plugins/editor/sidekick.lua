return {
  "folke/sidekick.nvim",
  event = "User File",
  opts = {
    cli = {
      mux = {
        enabled = true,
      },
    },
    nes = {
      enabled = vim.g.nes_enabled,
    },
  },
  keys = {
    {
      "<Tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply NES",
    },
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
      function()
        vim.g.nes_enabled = not vim.g.nes_enabled
        require("sidekick.nes").toggle()
        require("utils").notify(string.format("NES %s", require("utils").bool2str(vim.g.nes_enabled)))
      end,
      mode = { "n" },
      desc = "Toggle NES",
    },
    {
      "<Leader>anu",
      function() require("sidekick.nes").update() end,
      mode = { "n" },
      desc = "Update NES",
    },
    {
      "<Leader>ans",
      function()
        if require("sidekick.nes").have() then
          require("utils").notify "Suggestions available"
        else
          require("utils").notify "No suggestions available"
        end
      end,
      mode = { "n" },
      desc = "Show active suggestions",
    },
  },
}

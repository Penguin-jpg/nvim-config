return {
  "monkoose/neocodeium",
  event = "LspAttach",
  config = function()
    local neocodeium = require "neocodeium"
    local map = vim.keymap.set
    neocodeium.setup()

    map("n", "<Leader>t;", function() require("neocodeium.commands").toggle() end, { desc = "Toggle neocodeium" })
    map("i", "<A-a>", function() require("neocodeium").accept() end, { desc = "Accept current suggestion" })
    map(
      "i",
      "<S-Right>",
      function() require("neocodeium").accept_word() end,
      { desc = "Accept a word in current suggestion" }
    )
    map(
      "i",
      "<A-e>",
      function() require("neocodeium").accept_line() end,
      { desc = "Accept a line in current suggestion" }
    )
    map(
      "i",
      "<S-Down>",
      function() require("neocodeium").cycle_or_complete() end,
      { desc = "Cycle to next suggestion if available" }
    )
    map(
      "i",
      "<S-Up>",
      function() require("neocodeium").cycle_or_complete(-1) end,
      { desc = "Cycle to previous suggestion if available" }
    )
    map("i", "<A-x>", function() require("neocodeium").clear() end, { desc = "Clear current suggestion" })
  end,
}

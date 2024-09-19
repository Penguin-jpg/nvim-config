return {
  "monkoose/neocodeium",
  event = "LspAttach",
  config = function()
    local neocodeium = require "neocodeium"
    neocodeium.setup()
    vim.keymap.set("n", "<Leader>t;", function() require("neocodeium.commands").toggle() end)
    vim.keymap.set("i", "<A-a>", function() require("neocodeium").accept() end)
    vim.keymap.set("i", "<S-Right>", function() require("neocodeium").accept_word() end)
    vim.keymap.set("i", "<A-e>", function() require("neocodeium").accept_line() end)
    vim.keymap.set("i", "<S-Down>", function() require("neocodeium").cycle_or_complete() end)
    vim.keymap.set("i", "<S-Up>", function() require("neocodeium").cycle_or_complete(-1) end)
    vim.keymap.set("i", "<C-x>", function() require("neocodeium").clear() end)
  end,
}

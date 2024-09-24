return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim", -- optional
  },
  event = "User GitFile",
  config = true,
  keys = {
    { "<Leader>gg", "<Cmd>Neogit<CR>", desc = "Open Neogit" },
  },
}

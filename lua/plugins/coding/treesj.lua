return {
  "Wansmer/treesj",
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  opts = {
    use_default_keymaps = false,
    max_join_length = 150,
  },
  keys = {
    { "gj", "<Cmd>TSJToggle<CR>", mode = { "n" }, desc = "Toggle splitjoin" },
  },
}

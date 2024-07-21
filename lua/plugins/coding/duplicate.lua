return {
  "hinell/duplicate.nvim",
  keys = {
    { "<A-K>", "<Cmd>LineDuplicate -1<CR>", mode = { "n" }, desc = "Duplicate line up" },
    { "<A-J>", "<Cmd>LineDuplicate +1<CR>", mode = { "n" }, desc = "Duplicate line down" },
    { "<A-K>", "<Cmd>VisualDuplicate -1<CR>", mode = { "x" }, desc = "Duplicate block up" },
    { "<A-J>", "<Cmd>VisualDuplicate +1<CR>", mode = { "x" }, desc = "Duplicate block down" },
  },
}

return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup {
      chunk = {
        enable = true,
        notify = false,
        use_treesitter = true,
        chars = {
          horizontal_line = "━",
          vertical_line = "┃",
          left_top = "┏",
          left_bottom = "┗",
          right_arrow = "➤",
        },
        style = "#cba6f7",
        delay = 100,
      },
      indent = {
        enable = true,
        use_treesitter = false,
        chars = { "┃" },
      },
      blank = {
        enable = false,
      },
      line_num = {
        enable = false,
      },
    }
  end,
}

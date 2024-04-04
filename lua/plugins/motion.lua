-- Plugins related to motion
return {
  -- Move/duplicate lines up/down/left/right
  {
    "booperlv/nvim-gomove",
    event = "User AstroFile",
    config = function()
      require("gomove").setup {
        -- whether or not to map default key bindings, (true/false)
        map_defaults = false,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }
    end,
  },
  -- Better move by word support
  {
    "chaoren/vim-wordmotion",
    event = "User AstroFile",
  },
  -- Word/line substitution support
  {
    "gbprod/substitute.nvim",
    event = "User AstroFile",
    opts = {},
  },
  -- Split or join blocks of code
  {
    "Wansmer/treesj",
    event = "User AstroFile",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
    config = function(_, opts) require("treesj").setup(opts) end,
    keys = {
      { "sj", mode = { "n", "x" }, function() require("treesj").toggle() end, desc = "Split or join" },
    },
  },
  -- Faster change/delete/replace delimiter pairs
  {
    "echasnovski/mini.surround",
    event = "User AstroFile",
    opts = { n_lines = 200 },
    keys = {
      { "s", desc = vim.g.icon_enabled and "󰑤 " or "".. "Surround" },
      { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
      { "sr", desc = "Highlight surrounding" },
      { "sn", desc = "Replace surrounding" },
    },
  },
}
return {
  "otavioschwanck/arrow.nvim",
  event = "User File",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    show_icons = true,
    leader_key = ";", -- recommended to be a single key
    buffer_leader_key = "m", -- per buffer mappings
    mappings = {
      edit = "e",
      delete_mode = "d",
      clear_all_items = "c",
      toggle = "s", -- used as save if separate_save_and_remove is true
      open_vertical = "v",
      open_horizontal = "-",
      quit = "q",
      remove = "x", -- only used if separate_save_and_remove is true
      next_item = "]",
      prev_item = "[",
    },
  },
}

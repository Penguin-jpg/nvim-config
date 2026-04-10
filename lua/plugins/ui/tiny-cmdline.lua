return {
  "rachartier/tiny-cmdline.nvim",
  config = function()
    require("vim._core.ui2").enable {}
    require("tiny-cmdline").setup {
      width = {
        value = "60%",
        min = 40,
        max = 80,
      },
      position = {
        x = "50%",
        y = "20%",
      },
      menu_col_offset = 0,
      on_reposition = require("tiny-cmdline").adapters.blink,
    }
  end,
}

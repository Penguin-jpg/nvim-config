return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "User File",
  priority = 1000,
  opts = {
    preset = "modern",
    transparent_bg = false,
    transparent_cursorline = true,
    signs = {
      left = "",
      right = "",
      diag = "󰝤",
      arrow = " ",
      up_arrow = " ",
    },
    options = {
      show_source = {
        enabled = true,
        if_many = true, -- only show source if multiple sources exist for the same diagnostic
      },
      enable_on_insert = false,
      enable_on_select = false,
    },
  },
  config = function(_, opts)
    require("tiny-inline-diagnostic").setup(opts)
    vim.diagnostic.config { virtual_text = false }
  end,
}

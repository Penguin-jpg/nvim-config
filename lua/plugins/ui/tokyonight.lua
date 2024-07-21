return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  init = function() vim.cmd.colorscheme "tokyonight-night" end,
  opts = {
    style = "night",
    light_style = "day",
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    dim_inactive = true,
    on_colors = function(colors)
      colors.git.add = "#76946a"
      colors.git.change = "#dca561"
      colors.git.delete = "#c34043"
      colors.gitSigns = {
        change = "#dca561",
        add = "#76946a",
        delete = "#c34043",
      }
    end,
  },
}

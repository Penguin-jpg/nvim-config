return {
  "folke/tokyonight.nvim",
  lazy = true,
  -- priority = 1000,
  -- init = function() vim.cmd "colorscheme tokyonight" end,
  opts = {
    style = "night",
    light_style = "day",
    styles = {
      -- comments = { italic = false },
      -- keywords = { italic = false },
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
    on_highlights = function(hl, c) hl.PmenuSel = { fg = c.bg_dark, bg = "#7aa2f7" } end,
  },
}

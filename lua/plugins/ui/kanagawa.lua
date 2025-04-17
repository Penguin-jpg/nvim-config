return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  -- priority = 1000,
  -- init = function() vim.cmd "colorscheme kanagawa" end,
  opts = {
    theme = {
      all = {
        ui = {
          -- remove background of LineNr, SignColumn, and FoldColumn
          bg_gutter = "none",
        },
      },
    },
    dimInactive = true,
    overrides = function(colors)
      -- transparent floating windows
      local theme = colors.theme
      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        -- save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        MasonNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
      }
    end,
  },
}

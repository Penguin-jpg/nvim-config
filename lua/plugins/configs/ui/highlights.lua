return {
  init = function() -- this table overrides highlights in all themes
    local get_hlgroup = require("astroui").get_hlgroup
    local ui = require "astroui"
    local utils = require "astrocore"

    local hl = {
      -- remove background of virtual texts
      DiagnosticVirtualTextError = { fg = get_hlgroup("DiagnosticError").fg, bg = "none" },
      DiagnosticVirtualTextHint = { fg = get_hlgroup("DiagnosticHint").fg, bg = "none" },
      DiagnosticVirtualTextInfo = { fg = get_hlgroup("DiagnosticInfo").fg, bg = "none" },
      DiagnosticVirtualTextWarn = { fg = get_hlgroup("DiagnosticWarn").fg, bg = "none" },

      -- remove background of inlay hints
      LspInlayHint = { fg = get_hlgroup("LspInlayHint").fg, bg = "none" },
    }

    if utils.is_available "kanagawa.nvim" and ui.config.colorscheme == "kanagawa" then
      local colors = require("kanagawa.colors").setup()
      local theme = colors.theme
      hl = utils.extend_tbl(hl, {
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePromptNormalopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      })
    end

    return hl
  end,
  astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
    -- Normal = { bg = "#000000" },
  },
}

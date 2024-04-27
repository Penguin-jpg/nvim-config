return { 
  init = function() -- this table overrides highlights in all themes
    local colors = require("kanagawa.colors").setup()
    local theme = colors.theme
    return {
      -- For popup menu and floating window
      Pmenu = {fg = theme.ui.shade0, bg = theme.ui.bg_p1}, -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = {fg = 'NONE', bg = theme.ui.bg_p2},
      PmenuSbar = {bg = theme.ui.bg_m1},
      PmenuThumb = {bg = theme.ui.bg_p2},
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      -- For nvim-cmp menu item
      CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
      CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
      CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
      CmpItemMenu = { fg = "#C792EA", bg = "NONE", bold = true },
      CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
      CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
      CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
      CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
      CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
      CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
      CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
      CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
      CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
      CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
      CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
      CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
      CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
      CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },
      CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
      CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
      CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
      CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
      CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },
      CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
      CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
      CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
      CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
      CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
      CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
      -- For telescope
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
  end,
  astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
    -- Normal = { bg = "#000000" },
  },
}

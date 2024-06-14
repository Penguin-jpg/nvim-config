return {
  separators = {
    left = { " ", " " }, -- separator for the left side of the statusline
    right = { " ", "" }, -- separator for the right side of the statusline
    -- tab = { "", "" },
  },
  colors = function(hl)
    local get_hlgroup = require("astroui").get_hlgroup
    -- use helper function to get highlight group properties
    hl.blank_bg = get_hlgroup("Visual").bg
    hl.file_info_fg = "black"
    hl.file_info_bg = "#e2c88e"
    hl.git_branch_fg = "black"
    hl.git_branch_bg = "#a58bce"
    hl.file_encoding_bg = "#f7768e"
    hl.tab_width_bg = "#ff966c"
    hl.lsp_fg = "black"
    hl.lsp_bg = "#a7d0dd"
    hl.nav_fg = "black"
    hl.nav_bg = get_hlgroup("String").fg
    hl.nav_icon_bg = hl.nav_bg
    return hl
  end,
  attributes = {
    mode = { bold = true },
    file_info = { bold = true },
    git_branch = { bold = true },
    lsp = { bold = true },
  },
}

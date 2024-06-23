return {
  separators = {
    left = { " ", " " }, -- separator for the left side of the statusline
    right = { " ", "" }, -- separator for the right side of the statusline
    -- tab = { "", "" },
  },
  colors = function(hl)
    local get_hlgroup = require("astroui").get_hlgroup
    -- use helper function to get highlight group properties
    hl.normal = "#7daea3"
    hl.insert = "#a9b665"
    hl.visual = "#e8b142"
    hl.replace = "#ea6962"
    hl.command = "#e78a4e"
    hl.terminal = "#a89984"
    hl.file_info_fg = "black"
    hl.file_info_bg = "#ddc7a1"
    hl.git_branch_fg = "black"
    hl.git_branch_bg = "#e3c88f"
    hl.lsp_fg = "black"
    hl.lsp_bg = "#a7d0dd"
    hl.search_bg = "#e8b043"
    hl.file_encoding_bg = "#f7768e"
    hl.tab_width_bg = "#ff966c"
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

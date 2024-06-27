return {
  separators = {
    left = { " ", " " }, -- separator for the left side of the statusline
    right = { " ", "" }, -- separator for the right side of the statusline
    -- tab = { "", "" },
  },
  colors = function(hl)
    local get_hlgroup = require("astroui").get_hlgroup
    -- use helper function to get highlight group properties
    hl.insert = "#a9b665"
    hl.visual = "#e8b142"
    hl.replace = "#ea6962"
    hl.terminal = "#a89984"
    hl.file_info_fg = "#c9c193"
    hl.file_info_bg = "#bac2de"
    hl.git_branch_fg = "#eba0ac"
    hl.git_branch_bg = "#f5c2e7"
    hl.lsp_fg = "black"
    hl.lsp_bg = "#7fb4ca"
    hl.info_text_fg = "#b8b4d0"
    hl.search_bg = "#c8c093"
    hl.grapple_bg = "#eba0ac"
    hl.file_encoding_bg = "#f7768e"
    hl.tab_width_bg = "#ff966c"
    hl.nav_fg = "black"
    hl.nav_bg = get_hlgroup("String").fg
    hl.nav_icon_bg = hl.nav_bg
    return hl
  end,
  attributes = {
    mode = { bold = true },
    file_info = { bold = false },
    git_branch = { bold = false },
    diagnostics = { bold = false },
    git_diff = { bold = false },
    lsp = { bold = false },
  },
}

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
    hl.nav_icon_bg = get_hlgroup("String").fg
    hl.clock_bg = get_hlgroup("Error").fg
    return hl
  end,
  attributes = {
    mode = { bold = true },
  },
}

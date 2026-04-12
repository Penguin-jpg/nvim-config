return {
  "saghen/blink.pairs",
  version = "*",
  build = "cargo build --release",
  event = "InsertEnter",
  opts = {
    mappings = {
      enabled = true,
      cmdline = true,
      disabled_filetypes = {},
      wrap = {
        -- move closing pair via motion
        ["<C-b>"] = "motion",
        -- move opening pair via motion
        ["<C-S-b>"] = "motion_reverse",
        -- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
        -- set to nil, '' or false to disable the mapping
        -- normal_mode = {} <- for normal mode mappings, only supports 'motion' and 'motion_reverse'
      },
      pairs = {},
    },
    highlights = {
      enabled = true,
      cmdline = false,
      groups = {
        "BlinkPairsRed",
        "BlinkPairsYellow",
        "BlinkPairsBlue",
        "BlinkPairsOrange",
        "BlinkPairsGreen",
        "BlinkPairsPurple",
        "BlinkPairsCyan",
      },
      unmatched_group = "BlinkPairsUnmatched",
      -- highlights matching pairs under the cursor
      matchparen = {
        enabled = true,
        -- known issue where typing won't update matchparen highlight, disabled by default
        cmdline = false,
        -- also include pairs not on top of the cursor, but surrounding the cursor
        include_surrounding = false,
        group = "BlinkPairsMatchParen",
        priority = 250,
      },
    },
    debug = false,
  },
}

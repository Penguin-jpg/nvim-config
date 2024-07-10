-- Plugins related to UI
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = require("plugins.configs.ui.alpha").OH
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      opts.statusline = require("plugins.configs.ui.heirline").statusline
      opts.winbar = require("plugins.configs.ui.heirline").winbar
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      -- Do this to prevent the warning
      opts.background_colour = "#000000"
    end,
  },
  -- Icons support
  {
    "echasnovski/mini.icons",
    opts = function(_, opts)
      if vim.g.icons_enabled == false then opts.style = "ascii" end
    end,
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- Transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = function(_, opts) opts = require "plugins.configs.ui.transparent"(opts) end,
    keys = {
      { "<Leader>uT", "<Cmd>TransparentToggle<CR>", desc = "Toggle transparent" },
    },
  },
}

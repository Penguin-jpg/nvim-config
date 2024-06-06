-- Plugins related to UI
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = require("plugins.configs.ui.alpha").UWU
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
  -- Transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = function(_, opts) opts = require "plugins.configs.ui.transparent"(opts) end,
    keys = {
      { "<Leader>uT", "<Cmd>TransparentToggle<CR>", desc = "Toggle transparent" },
    },
  },
  -- Enhance UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(
            opts.ensure_installed,
            { "bash", "markdown", "markdown_inline", "regex", "vim" }
          )
        end
      end,
    },
    opts = function(_, opts) return require("astrocore").extend_tbl(opts, require "plugins.configs.ui.noice") end,
    init = function() vim.g.lsp_handlers_enabled = false end,
  },
}

-- Plugins related to UI
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = require("plugins.configs.ui.alpha").UWU
      return opts
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      require "astrocore".extend_tbl(opts, require("plugins.configs.ui.colorscheme").catppuccin)
      return opts
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = function(_, opts)
      require "astrocore".extend_tbl(opts, require("plugins.configs.ui.colorscheme").kanagawa)
      return opts
    end,
  },
  {
    "navarasu/onedark.nvim",
    opts = function(_, opts)
      require "astrocore".extend_tbl(opts, require("plugins.configs.ui.colorscheme").onedark)
      return opts
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { 
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require "astrocore".list_insert_unique(
            opts.ensure_installed,
            { "bash", "markdown", "markdown_inline", "regex", "vim" }
          )
        end
      end,
    },
    opts = function(_, opts)
      return require "astrocore".extend_tbl(opts, require("plugins.configs.ui.noice")
    end,
    init = function() vim.g.lsp_handlers_enabled = false end,
  },
}
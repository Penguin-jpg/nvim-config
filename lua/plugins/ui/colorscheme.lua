-- Plugins related to colorscheme
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      color_overrides = {
        mocha = {
          rosewater = "#efc9c2",
          flamingo = "#ebb2b2",
          pink = "#f2a7de",
          mauve = "#b889f4",
          red = "#ea7183",
          maroon = "#ea838c",
          peach = "#f39967",
          yellow = "#eaca89",
          green = "#96d382",
          teal = "#78cec1",
          sky = "#91d7e3",
          sapphire = "#68bae0",
          blue = "#739df2",
          lavender = "#a0a8f6",
          text = "#b5c1f1",
          subtext1 = "#a6b0d8",
          subtext0 = "#959ec2",
          overlay2 = "#848cad",
          overlay1 = "#717997",
          overlay0 = "#63677f",
          surface2 = "#505469",
          surface1 = "#3e4255",
          surface0 = "#2c2f40",
          base = "#1a1c2a",
          mantle = "#141620",
          crust = "#0e0f16",
        },
      },
      integrations = {
        alpha = true,
        aerial = false,
        dap = { enabled = true, enable_ui = true },
        mason = true,
        neotree = true,
        notify = true,
        nvimtree = false,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        which_key = true,
        noice = true,
        rainbow_delimiters = true,
        cmp = true,
        gitsigns = true,
        treesitter = true,
        lsp_trouble = true,
        neogit = true,
      },
    },
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
      opts.overrides = function(colors)
        return {
          RainbowDelimiterRed = { fg = colors.palette.autumnRed },
          RainbowDelimiterYellow = { fg = colors.palette.carpYellow },
          RainbowDelimiterBlue = { fg = colors.palette.dragonBlue },
          RainbowDelimiterOrange = { fg = colors.palette.surimiOrange },
          RainbowDelimiterGreen = { fg = colors.palette.springGreen },
          RainbowDelimiterViolet = { fg = colors.palette.oniViolet },
          RainbowDelimiterCyan = { fg = colors.palette.waveAqua1 },
        }
      end
      return opts
    end,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "darker",
        colors = {
          pink = "#C087B5",
          fg = "#A8B1BF",
          dark_yellow = "#DDAA56",
          light_grey = "#8A91A8",
        },
        highlights = {
          ["@comment"] = { fg = "$pink" },
          ["@lsp.type.comment"] = { fg = "$pink" },
          ["@punctuation.delimiter"] = { fg = "$light_grey" },
          ["@punctuation.bracket"] = { fg = "$orange" },
        },
      }
    end,
  },
}
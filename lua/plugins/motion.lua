-- Plugins related to motion
return {
  -- Move/duplicate lines up/down/left/right
  {
    "booperlv/nvim-gomove",
    event = "User AstroFile",
    config = function()
      require("gomove").setup {
        -- whether or not to map default key bindings, (true/false)
        map_defaults = false,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }
    end,
  },
  -- Better move by word support
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local key_maps = {
          ["w"] = {
            "<Cmd>lua require('spider').motion('w')<CR>",
            desc = "Next word",
          },

          ["e"] = {
            "<Cmd>lua require('spider').motion('e')<CR>",
            desc = "Next end of word",
          },
          ["b"] = {
            "<Cmd>lua require('spider').motion('b')<CR>",
            desc = "Previous word",
          },
          ["ge"] = {
            "<Cmd>lua require('spider').motion('ge')<CR>",
            desc = "Previous end of word",
          },
        }

        for key, map in pairs(key_maps) do
          opts.mappings.n[key] = map
          opts.mappings.x[key] = map
          opts.mappings.o[key] = map
        end

      end
    },
    opts = {},
  },
  -- Faster change/delete/replace delimiter pairs
  {
    "echasnovski/mini.surround",
    event = "User AstroFile",
    opts = { n_lines = 200 },
    keys = {
      { "s", desc = vim.g.icon_enabled and "󰑤 " or "".. "Surround" },
      { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
      { "sr", desc = "Highlight surrounding" },
      { "sn", desc = "Replace surrounding" },
    },
  },
}

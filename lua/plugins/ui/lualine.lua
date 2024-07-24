return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local conditions = require("utils.lualine").conditions
    local get_icon = require("utils.icons").get_icon

    local opts = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = "auto",
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" }, padding = { left = 0, right = 0 } } },
        lualine_b = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
            color = { bg = "none" },
          },
          {
            "filename",
            padding = { left = 0, right = 0 },
            color = { fg = "#c7d1d9", bg = "none" },
            cond = conditions.buffer_not_empty,
          },
        },
        lualine_c = {
          {
            "branch",
            icon = get_icon("git", "Branch"),
            padding = { left = 2, right = 1 },
            color = { fg = "#d3879a", bg = "none" },
          },
          {
            "diagnostics",
            symbols = {
              error = get_icon("diagnostic", "Error") .. " ",
              warn = get_icon("diagnostic", "Warn") .. " ",
              info = get_icon("diagnostic", "Info") .. " ",
              hint = get_icon("diagnostic", "Hint") .. " ",
            },
          },
          {
            "diff",
            symbols = {
              added = get_icon("git", "Add") .. " ",
              modified = get_icon("git", "Change") .. " ",
              removed = get_icon("git", "Delete") .. " ",
            },
            cond = conditions.hide_in_width,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_x = {
          {
            "searchcount",
            maxcount = 999,
            timeout = 500,
            color = { fg = "#f7768e", bg = "none" },
          },
        },
        lualine_y = {
          {
            "encoding",
            fmt = string.upper,
            icon = get_icon("misc", "FileEncoding"),
            color = { fg = "#c7d1d9", bg = "none" },
          },
          {
            "bo:tabstop",
            icon = get_icon("misc", "TabWidth"),
            color = { fg = "#c7d1d9", bg = "none" },
          },
        },
        lualine_z = {
          {
            "location",
            separator = { left = "" },
            padding = { left = 1, right = 1 },
            color = { fg = "black", bg = "#97c568" },
          },
          {
            "progress",
            separator = { right = "" },
            padding = { left = 0, right = 0 },
            color = { fg = "black", bg = "#97c568" },
          },
        },
      },
    }

    return opts
  end,
}

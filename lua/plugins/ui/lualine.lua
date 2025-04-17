return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.opt.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.opt.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.opt.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness
    local lualine_require = require "lualine_require"
    lualine_require.require = require

    local ui_utils = require "utils.ui"
    local conditions = ui_utils.lualine.conditions
    local get_icon = ui_utils.get_icon
    local colorscheme = ui_utils.get_colorscheme_name()
    local bg_dark = "#16161e"
    if colorscheme == "tokyonight" then
      bg_dark = "#16161e"
    elseif colorscheme == "kanagawa" then
      bg_dark = "#2a2a37"
    elseif colorscheme == "catppuccin" then
      bg_dark = "#201c24"
    else
      bg_dark = "#1f1f28"
    end

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.opt.laststatus == 3,
        component_separators = "",
        section_separators = "",
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "", right = "" },
            padding = { left = 0, right = 0 },
            color = { gui = "bold" },
          },
        },
        lualine_b = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
            color = { bg = bg_dark },
          },
          {
            "filename",
            padding = { left = 0, right = 0 },
            color = { fg = "#b0baf2", bg = bg_dark },
            cond = conditions.buffer_not_empty,
          },
        },
        lualine_c = {
          {
            "branch",
            icon = get_icon "GitBranch",
            padding = { left = 2, right = 1 },
            color = { fg = "#d183e8" },
          },
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "" end -- not recording
              return "Recording @" .. reg
            end,
            color = { fg = "#60b2a7" },
          },
          "%=",
          {
            "diagnostics",
            symbols = {
              error = get_icon("DiagnosticError", 1),
              warn = get_icon("DiagnosticWarn", 1),
              info = get_icon("DiagnosticInfo", 1),
              hint = get_icon("DiagnosticHint", 1),
            },
            icon = get_icon "Diagnostic",
            color = { fg = "#f1a185" },
          },
          {
            "diff",
            symbols = {
              added = get_icon("GitAdd", 1),
              modified = get_icon("GitChange", 1),
              removed = get_icon("GitDelete", 1),
            },
            icon = get_icon "Github",
            color = { fg = "#bb49b3" },
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
            color = { fg = "#f7768e", bg = bg_dark },
          },
          {
            function()
              local buf_ft = vim.api.nvim_get_option_value("filetype", {})
              local clients = vim.lsp.get_clients()

              if next(clients) == nil then return "No Active LSP" end

              local names = {}

              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then table.insert(names, client.name) end
              end
              return table.concat(names, ", ")
            end,
            separator = { left = "", right = "" },
            padding = { left = 0, right = 0 },
            icon = "",
            color = { fg = "black", bg = "#7fb4ca" },
          },
        },
        lualine_y = {
          {
            "encoding",
            fmt = string.upper,
            icon = "",
            padding = { left = 2, right = 1 },
            color = { fg = "#60b2a7", bg = bg_dark },
          },
          {
            "bo:tabstop",
            icon = "",
            padding = { left = 1, right = 1 },
            color = { fg = "#60b2a7", bg = bg_dark },
          },
          {
            "fileformat",
            symbols = {
              unix = " LF",
              dos = " CRLF",
              mac = " CR",
            },
            padding = { left = 1, right = 2 },
            color = { fg = "#60b2a7", bg = bg_dark },
          },
        },
        lualine_z = {
          {
            "location",
            separator = { left = "" },
            padding = { left = 0, right = 1 },
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
      extensions = { "lazy" },
    }

    return opts
  end,
}

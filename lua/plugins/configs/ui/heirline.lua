local M = {}
local status = require "astroui.status"
local core = require "astrocore"
local path_func = status.provider.filename { modify = ":.:h", fallback = "" }

-- custom statusline
M.statusline = {
  hl = { fg = "fg", bg = "bg" },
  -- Show mode text
  status.component.mode {
    -- enable mode text with padding as well as an icon before it
    mode_text = {
      mode_text = { padding = { left = 1, right = 1 } },
    },
    -- surround the component with a separators
    surround = {
      separator = "left",
    },
  },
  status.component.file_info {
    file_icon = { padding = { left = 0, right = 1 } },
    filename = { fallback = "Empty" },
    filetype = false,
    file_modified = false,
    surround = {
      separator = "left",
    },
  },
  status.component.git_branch {
    surround = {
      separator = "left",
      -- color = "bg",
    },
  },
  status.component.fill(),
  status.component.diagnostics {
    surround = {
      separator = "none",
      color = "bg",
    },
  },
  status.component.git_diff {
    padding = { left = 1 },
    surround = {
      separator = "none",
      color = "bg",
    },
  },
  status.component.fill(),
  {
    condition = function(self)
      local query = vim.fn.getreg "/"
      if query == "" then return false end
      query = query:gsub([[^\V]], "")
      query = query:gsub([[\<]], ""):gsub([[\>]], "")

      local search_count = vim.fn.searchcount { recompute = 1, maxcount = -1 }
      if search_count.total == 0 then return false end

      self.query = query
      self.count = search_count
      return true
    end,
    status.component.builder {
      {
        provider = function(self)
          return status.utils.stylize(" " .. self.query .. " " .. self.count.current .. "/" .. self.count.total, {
            icon = { kind = "Search" },
          })
        end,
      },
      hl = { fg = "black", bold = true },
      surround = {
        separator = "left",
        color = "search_bg",
      },
    },
  },
  status.component.lsp {
    lsp_client_names = {
      icon = { kind = "ActiveLSP", padding = { right = 1 } },
    },
    surround = { separator = "left" },
  },
  -- Show file encoding
  status.component.builder {
    {
      provider = function()
        return status.utils.stylize(vim.bo.fileencoding, {
          icon = { kind = "FileEncoding", padding = { right = 1 } },
        })
      end,
    },
    hl = { fg = "black" },
    surround = {
      separator = "left",
      color = "file_encoding_bg",
    },
  },
  -- Show tab width
  status.component.builder {
    {
      provider = function()
        return status.utils.stylize(tostring(vim.bo.tabstop), {
          icon = { kind = "TabWidth", padding = { right = 1 } },
        })
      end,
    },
    hl = { fg = "black" },
    surround = {
      separator = "left",
      color = "tab_width_bg",
    },
  },
  {
    status.component.builder {
      { provider = require("astroui").get_icon "ScrollText" },
      padding = { right = 1 },
      hl = { fg = "bg" },
      surround = {
        separator = { " ", "" },
        color = { main = "nav_icon_bg", left = "bg" },
      },
    },
    status.component.nav {
      percentage = { padding = { left = 0 } },
      ruler = false,
      scrollbar = false,
      surround = { separator = { "", "" } },
    },
  },
}

-- custom winbar
M.winbar = {
  -- store the current buffer number
  init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
  fallthrough = false, -- pick the correct winbar based on condition
  -- inactive winbar
  {
    condition = function() return not status.condition.is_active() end,
    -- show the path to the file relative to the working directory
    status.component.separated_path { path_func = path_func },
    -- add the file name and icon
    status.component.file_info {
      file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
      filename = {},
      filetype = false,
      file_modified = false,
      file_read_only = false,
      hl = status.hl.get_attributes("winbarnc", true),
      surround = false,
      update = "BufEnter",
    },
  },
  -- active winbar
  {
    -- show the path to the file relative to the working directory
    status.component.separated_path { path_func = path_func },
    -- add the file name and icon
    status.component.file_info { -- add file_info to breadcrumbs
      file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
      filename = {},
      filetype = false,
      file_modified = false,
      file_read_only = false,
      hl = status.hl.get_attributes("winbar", true),
      surround = false,
      update = "BufEnter",
    },
    -- show the breadcrumbs
    status.component.breadcrumbs {
      icon = { hl = true },
      hl = status.hl.get_attributes("winbar", true),
      prefix = true,
      padding = { left = 0 },
    },
  },
}

return M

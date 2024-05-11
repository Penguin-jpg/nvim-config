local M = {}
local status = require("astroui.status")
local path_func = status.provider.filename { modify = ":.:h", fallback = "" }

-- My custom statusline
M.statusline = {
  hl = { fg = "fg", bg = "bg" },
  -- Show mode text
  status.component.mode({
    -- enable mode text with padding as well as an icon before it
    mode_text = {
      mode_text = { padding = { left = 1, right = 1 } },
    },
    -- surround the component with a separators
    surround = {
      separator = "left",
    },
  }),
  status.component.file_info({
    filename = { fallback = "Empty" },
    filetype = false,
    file_modified = false,
    surround = {
      separator = { "", " " },
      color = "bg",
    },
  }),
  status.component.diagnostics({
    surround = {
      separator = "none",
      color = "bg",
    },
  }),
  status.component.git_branch({
    git_branch = { padding = { left = 1 } },
    surround = {
      separator = "none",
      color = "bg",
    },
  }),
  status.component.git_diff({
    padding = { left = 1 },
    surround = { 
      separator = "none",
      color = "bg",
    },
  }),
  status.component.fill(),
  status.component.cmd_info(),
  -- status.component.fill(),
  -- Show file encoding
  -- status.component.builder({
  --   {
  --     provider = "file_encoding",
  --     opts = { padding = { left = 1, right = 1 } },
  --   },
  -- }),
  status.component.lsp {
    surround = {
      color = function() return { main = "bg" } end
    }
  },
  status.component.virtual_env(),
  {
    -- make nav section with icon border
    -- define a custom component with just a file icon
    status.component.builder({
      { provider = require("astroui").get_icon("Navigation") },
      -- add padding after icon
      padding = { right = 1 },
      -- set the icon foreground
      hl = { fg = "bg" },
      -- use the right separator and define the background color
      -- as well as the color to the left of the separator
      surround = {
        separator = "right",
        color = "nav_icon_bg",
      },
    }),
    -- add a navigation component and just display the percentage of progress in the file
    status.component.nav({
      -- add some padding for the percentage provider
      -- percentage = { padding = { left = 1 } },
      -- use no separator and define the background color
      surround = { separator = "none", color = "blank_bg" },
    }),
  },
}

-- My custom winbar
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

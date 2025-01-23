local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<C-" .. dir .. ">" or vim.schedule(function() vim.cmd.wincmd(dir) end)
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      scope = {
        enabled = true,
        char = "┃",
      },
      chunk = {
        enabled = true,
        char = {
          corner_top = "┏",
          corner_bottom = "┗",
          horizontal = "━",
          vertical = "┃",
          arrow = "▶",
        },
      },
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      style = "fancy",
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false }, -- set in options.lua
    scroll = { enabled = false },
    terminal = {
      win = {
        keys = {
          nav_h = { "<C-h>", term_nav "h", desc = "Go to left Window", expr = true, mode = "t" },
          nav_j = { "<C-j>", term_nav "j", desc = "Go to lower Window", expr = true, mode = "t" },
          nav_k = { "<C-k>", term_nav "k", desc = "Go to upper Window", expr = true, mode = "t" },
          nav_l = { "<C-l>", term_nav "l", desc = "Go to right Window", expr = true, mode = "t" },
        },
      },
    },
    words = { enabled = true },
    -- TODO: configure picker
  },
  config = function(_, opts)
    local notify = vim.notify
    require("snacks").setup(opts)
    -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
    -- this is needed to have early notifications show up in noice history
    vim.notify = notify
  end,
  keys = {
    {
      "<Leader>bd",
      function() Snacks.bufdelete() end,
      desc = "Delete buffer",
    },
    {
      "<Leader>bo",
      function() Snacks.bufdelete.other() end,
      desc = "Delete other buffers",
    },
    {
      "<Leader>un",
      function() Snacks.notifier.hide() end,
      desc = "Clear notifications",
    },
    {
      "<Leader>fn",
      function() Snacks.notifier.show_history() end,
      desc = "Find notifications",
    },
    {
      "<Leader>gB",
      function() Snacks.git.blame_line() end,
      desc = "Show git blame",
    },
    {
      "<Leader>go",
      function() Snacks.gitbrowse() end,
      desc = "Open github repo in browser",
    },
    {
      "<Leader>gl",
      function() Snacks.lazygit() end,
      desc = "Open lazygit",
    },
    {
      "`",
      function() Snacks.terminal() end,
      desc = "Toggle terminal",
    },
    {
      "[r",
      function() Snacks.words.jump(vim.v.count1) end,
      mode = { "n", "t" },
      desc = "Previous reference",
    },
    {
      "]r",
      function() Snacks.words.jump(-vim.v.count1) end,
      mode = { "n", "t" },
      desc = "Next reference",
    },
  },
}

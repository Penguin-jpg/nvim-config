return {
  "nvimdev/dashboard-nvim",
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    local header = require("utils.ui").get_header "OH"
    local get_icon = require("utils.ui").get_icon

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(header, "\n"),
        center = {
          {
            action = "Oil",
            desc = "File Explorer",
            icon = " ",
            key = "e",
          },
          { action = "ene", desc = "New File", icon = get_icon("FileDefault", 1), key = "n" },
          { action = "Telescope find_files", desc = "Find File", icon = " ", key = "f" },
          {
            action = "Telescope live_grep",
            desc = "Find Word",
            icon = "󱎸 ",
            key = "w",
          },
          {
            action = function() require("persistence").load { last = true } end,
            desc = "Load last session",
            icon = "󰆓 ",
            key = "s",
          },
          { action = "qa", desc = "Quit", icon = get_icon("DiagnosticError", 1) .. " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function() vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" }) end)
        end,
      })
    end

    return opts
  end,
}

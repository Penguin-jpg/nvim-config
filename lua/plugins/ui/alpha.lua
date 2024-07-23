return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  cmd = "Alpha",
  opts = function()
    local dashboard = require "alpha.themes.dashboard"

    dashboard.section.header.val = require("utils.alpha").get_header "OH"
    dashboard.section.buttons.val = {
      dashboard.button(
        "SPC e",
        require("utils.icons").get_icon("plugins", "Yazi") .. " File Explorer",
        "<Cmd>lua require('yazi').yazi()<CR>"
      ),
      dashboard.button("SPC n", require("utils.icons").get_icon("files", "Default") .. " New File", "<Cmd>enew<CR>"),
      dashboard.button(
        "SPC f f",
        require("utils.icons").get_icon("misc", "Search") .. " Find File",
        "<Cmd>Telescope find_files<CR>"
      ),
      dashboard.button(
        "SPC f w",
        require("utils.icons").get_icon("misc", "WordSearch") .. " Find Word",
        "<Cmd>Telescope live_grep<CR>"
      ),
      dashboard.button("CTRL q", require("utils.icons").get_icon("diagnostic", "Error") .. " Quit", "<Cmd>qa<CR>"),
    }

    return dashboard
  end,
  config = function(_, opts)
    require("alpha").setup(opts.config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      desc = "Add Alpha dashboard footer",
      once = true,
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        opts.section.footer.val =
          { "Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins  in " .. ms .. "ms" }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}

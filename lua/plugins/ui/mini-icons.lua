return {
  "nvim-mini/mini.icons",
  lazy = true,
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  opts = function(_, opts)
    if vim.g.icons_enabled == false then opts.style = "ascii" end
  end,
}

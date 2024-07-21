return {
  "echasnovski/mini.icons",
  lazy = true,
  specs = {
    { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
  },
  opts = function(_, opts)
    if vim.g.icons_enabled == false then opts.style = "ascii" end
  end,
}

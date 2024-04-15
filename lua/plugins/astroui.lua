-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing


---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = function(_, opts)
    -- change colorscheme
    opts.colorscheme = "catppuccin"

    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    opts.highlights = require("plugins.configs.ui.highlights")

    -- Icons can be configured throughout the interface
    opts.icons = require("plugins.configs.ui.icons")(opts.icons)

    opts.status = require("plugins.configs.ui.status")(opts.status)
     
    return opts
  end
}
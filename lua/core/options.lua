return {
  -- vim.opt.<key>
  opt = {
    relativenumber = true,                                   -- sets vim.opt.relativenumber
    number = true,                                           -- sets vim.opt.number
    spell = false,                                           -- sets vim.opt.spell
    signcolumn = "yes",                                      -- always show the signcolumn, otherwise it would shift the text each time
    wrap = false,                                            -- disable auto wrap lines
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20", -- default cursor setting
    clipboard = "unnamedplus",                               -- enable system clipboard
    termguicolors = true,                                    -- true color support
    mouse = "a",                                             -- enable mouse
    mousemoveevent = true,                                   -- enable mousemove event
    laststatus = 2,                                          -- only show one statusline
    swapfile = false,                                        -- don't use swapfile
    shiftwidth = 4,                                          -- number of space inserted for indentation; when zero the 'tabstop' value will be used
    tabstop = 4,                                             -- set the number of space in a tab to 4
    softtabstop = 4,                                         -- can be differnt from tabstop
    showtabline = 2,                                         -- always show tabline
    expandtab = true,                                        -- use spaces instead of tab
  },
  -- vim.g.<key>
  g = {
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
  },
}

return {
  -- vim.opt.<key>
  opt = {
    number = true, -- show line number
    relativenumber = true, -- show relative line number
    spell = false, -- disable spell check
    wrap = false, -- disable auto wrap lines
    signcolumn = "yes", -- show changes of file
    foldcolumn = "1", -- show foldcolumn
    foldenable = true, -- enable fold for nvim-ufo
    foldlevel = 99, -- set high foldlevel for nvim-ufo
    foldlevelstart = 99, -- start with all code unfolded
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20", -- default cursor setting
    clipboard = "unnamedplus", -- enable system clipboard
    termguicolors = true, -- true color support
    mouse = "a", -- enable mouse
    mousemoveevent = true, -- enable mousemove event
    laststatus = 3, -- only show one statusline
    swapfile = false, -- don't use swapfile
    shiftwidth = 4, -- number of space inserted for indentation; when zero the 'tabstop' value will be used
    tabstop = 4, -- set the number of space in a tab to 4
    softtabstop = 4, -- can be differnt from tabstop
    showtabline = 2, -- always show tabline
    expandtab = true, -- use spaces instead of tab
    undofile = true, -- enable persistent undo
  },
  -- vim.g.<key>
  g = {
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
  },
}

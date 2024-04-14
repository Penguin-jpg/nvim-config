return function(options)
  -- vim.opt.<key>
  options.opt = {
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn
    wrap = false, -- auto wrap lines
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20", -- default cursor setting
    ve = "onemore", -- can move cursor next to the end of the line
    clipboard = "unnamedplus", -- enable system clipboard
    mouse = "a", -- enable mouse
    mousemoveevent = true, -- enable mousemove event
    laststatus = 2, -- only show one statusline
    showtabline = 2, -- always show tabline
  }

  -- vim.g.<key>
  options.g = {
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
  }
  
  return options
end
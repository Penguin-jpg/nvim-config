return function(options)
  -- vim.opt.<key>
  options.opt = {
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20", -- sets vim.opt.guicursor
    ve = "onemore", -- sets vim.opt.ve
    clipboard = "unnamedplus", -- sets vim.opt.clipboard
    mouse = "a", -- sets vim.opt.mouse
    mousemoveevent = true, -- sets vim.opt.mousemoveevent
  }

  -- vim.g.<key>
  options.g = {
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
  }
  
  return options
end
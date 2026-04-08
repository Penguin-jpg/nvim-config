return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter immediately when opening a file from the cmdline
    event = "User File",
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUninstall", "TSUpdate", "TSLog" },
    build = ":TSUpdate",
    config = function()
      -- install parsers
      local ensure_installed = {
        "bash",
        "vim",
        "vimdoc",
        "regex",
        "make",
        "c",
        "cpp",
        "cuda",
        "lua",
        "python",
        "json",
        "markdown",
        "markdown_inline",
        "latex",
        "html",
      }
      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser) return not vim.tbl_contains(installed, parser) end)
        :totable()
      require("nvim-treesitter").install(to_install)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          -- enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start)
          -- enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = "User File",
    opts = { select = { lookahead = true } },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User File",
    cmd = { "TSContextToggle" },
    opts = {},
    keys = {
      {
        "<Leader>uT",
        "<Cmd>TSContextToggle<CR>",
        desc = "Toggle treesitter context",
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "User File",
    opts = {},
  },
}

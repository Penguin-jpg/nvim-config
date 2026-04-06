return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter immediately when opening a file from the cmdline
    event = "VeryLazy",
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUninstall", "TSUpdate", "TSLog" },
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ensure_installed = {
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
        "jsonc",
        "markdown",
        "markdown_inline",
        "latex",
        "html",
      },
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = "User File",
    opts = {
      select = { lookahead = true },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        -- LazyVim extention to create buffer-local keymaps
        keys = {
          goto_next_start = {
            ["]k"] = "@block.outer",
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]K"] = "@block.outer",
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[k"] = "@block.outer",
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[K"] = "@block.outer",
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
          swap_next = {
            [">k"] = "@block.outer",
            [">f"] = "@function.outer",
            [">a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<k"] = "@block.outer",
            ["<f"] = "@function.outer",
            ["<a"] = "@parameter.inner",
          },
        },
      },
    },
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
  {
    "windwp/nvim-ts-autotag",
    event = "User File",
    opts = {},
  },
}

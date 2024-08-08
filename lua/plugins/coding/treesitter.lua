return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true } },
    event = require("utils.lazy").LazyFile,
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    build = ":TSUpdate",
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      pcall(require, "nvim-treesitter.query_predicates")
    end,
    opts_extend = { "ensure_installed" },
    opts = {
      auto_install = vim.fn.executable "git" == 1 and vim.fn.executable "tree-sitter" == 1, -- only enable auto install if `tree-sitter` cli is installed
      ensure_installed = {
        "bash",
        "vim",
        "vimdoc",
        "regex",
        "c",
        "cpp",
        "lua",
        "python",
        "json",
        "jsonc",
        "markdown",
        "markdown_inline",
        "html",
      },
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
          },
          goto_next_end = {
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
          },
          goto_previous_start = {
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
          },
          goto_previous_end = {
            ["[K"] = { query = "@block.outer", desc = "Previous block end" },
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">k"] = { query = "@block.outer", desc = "Swap next block" },
            [">f"] = { query = "@function.outer", desc = "Swap next function" },
            [">a"] = { query = "@parameter.inner", desc = "Swap next argument" },
          },
          swap_previous = {
            ["<k"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<f"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<a"] = { query = "@parameter.inner", desc = "Swap previous argument" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = require("utils.lazy").LazyFile,
    enabled = vim.fn.has "nvim-0.10.0" == 1,
  },
  {
    "windwp/nvim-ts-autotag",
    event = require("utils.lazy").LazyFile,
    opts = {},
  },
}

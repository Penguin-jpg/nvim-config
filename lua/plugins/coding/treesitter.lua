return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true } },
    event = "User File",
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
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
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
        "query",
        "regex",
        "c",
        "cpp",
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
    config = function(plugin, opts)
      local ts = require(plugin.main)
      if vim.fn.executable "git" == 0 then opts.ensure_installed = nil end
      ts.setup(opts)
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    init = function()
      if vim.fn.has "nvim-0.10" == 1 then
        -- HACK: add workaround for native comments: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/109
        vim.schedule(function()
          local get_option = vim.filetype.get_option
          local context_commentstring
          vim.filetype.get_option = function(filetype, option)
            if option ~= "commentstring" then return get_option(filetype, option) end
            if context_commentstring == nil then
              local ts_context_avail, ts_context = pcall(require, "ts_context_commentstring.internal")
              context_commentstring = ts_context_avail and ts_context
            end
            return context_commentstring and context_commentstring.calculate_commentstring()
              or get_option(filetype, option)
          end
        end)
      end
    end,
    opts = { enable_autocmd = false },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "User File",
    opts = {},
  },
}

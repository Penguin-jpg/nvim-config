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
    event = "BufReadPost",
    opts = {
      select = { lookahead = true },
      move = { set_jumps = true },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
      -- set keymaps
      local textobjects = {
        move = {
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
          swap_next = {
            [">K"] = { query = "@block.outer", desc = "Swap next block" },
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
            [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
          },
          swap_previous = {
            ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
          },
        },
      }
      local modes = { move = { "n", "x", "o" }, swap = { "n" } }
      for type, methods in pairs(textobjects) do
        local mode = modes[type]
        for method, keys in pairs(methods) do
          for key, opt in pairs(keys) do
            vim.keymap.set(
              mode,
              key,
              function() require("nvim-treesitter-textobjects." .. type)[method](opt.query, group) end,
              { desc = opt.desc, silent = true }
            )
          end
        end
      end
    end,
  },
  {
    "folke/ts-comments.nvim",
    event = "User File",
    opts = {},
  },
}

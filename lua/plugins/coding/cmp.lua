local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
local function is_visible(cmp) return cmp.core.view:visible() or vim.fn.pumvisible() == 1 end

return {
  -- completion engine
  {
    -- "hrsh7th/nvim-cmp",
    -- version = false,
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp", -- Otherwise highlighting gets messed up
    event = "InsertEnter",
    dependencies = {
      -- sources for completion
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
    },
    opts_extend = { "sources" },
    config = function()
      -- See `:help cmp`
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      cmp.setup {
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500, group_index = 2 },
          { name = "path", priority = 250 },
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered {
            scrollbar = false,
            col_offset = -2,
            side_padding = 0,
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = cmp.config.window.bordered {
            border = "rounded",
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
          },
        },
        formatting = {
          -- show icon at the beginning and menu at the end
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            local kind_icon = require("utils.ui").get_icon("kind", vim_item.kind)
            local source = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })[entry.source.name]

            vim_item.menu = vim_item.kind
            vim_item.menu_hl_group = "CmpItemKind" .. vim_item.kind
            vim_item.kind = " " .. kind_icon
            return vim_item
          end,
          expandable_indicator = true,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = {
          -- esc to close completion menu
          ["<Esc>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          -- select items
          ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          -- scroll documents
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          -- manually trigger completion
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          -- tab or enter to select completion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.confirm { select = true }
            else
              fallback()
            end
          end, { "i", "s" }),
          -- use <C-n> and <C-p> to select luasnip
          ["<C-n>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      }
    end,
  },
  -- snippet engine
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = vim.fn.has "win32" == 0
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
    dependencies = {
      { "rafamadriz/friendly-snippets", lazy = true },
      {
        -- "hrsh7th/nvim-cmp",
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp", -- Otherwise highlighting gets messed up
        dependencies = { { "saadparwaiz1/cmp_luasnip", lazy = true } },
        opts = function(_, opts)
          local luasnip, cmp = require "luasnip", require "cmp"

          if not opts.snippet then opts.snippet = {} end
          opts.snippet.expand = function(args) luasnip.lsp_expand(args.body) end

          if not opts.sources then opts.sources = {} end
          table.insert(opts.sources, { name = "luasnip", priority = 750 })

          if not opts.mapping then opts.mapping = {} end
          opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
            if is_visible(cmp) then
              cmp.select_next_item()
            elseif vim.api.nvim_get_mode().mode ~= "c" and luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" })
          opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
            if is_visible(cmp) then
              cmp.select_prev_item()
            elseif vim.api.nvim_get_mode().mode ~= "c" and luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      require("luasnip").config.setup(opts)
      require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  -- manage libuv types with lazy, this plugin will never be loaded
  { "Bilal2453/luvit-meta", lazy = true },
  -- add lazydev source to cmp
  {
    -- "hrsh7th/nvim-cmp",
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp", -- Otherwise highlighting gets messed up
    opts = function(_, opts) table.insert(opts.sources, { name = "lazydev", group_index = 0 }) end,
  },
}

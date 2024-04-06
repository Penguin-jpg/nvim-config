return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    local function has_words_before()
      local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    return require "astrocore".extend_tbl(opts, {
      -- Always select the first option
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      -- Custom mapping
      mapping = {
        -- Esc to close completion menu
        ["<Esc>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        -- Tab to select completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Use <C-n> and <C-p> to select luasnip
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
    })
  end,
}
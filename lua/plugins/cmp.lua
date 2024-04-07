return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    local function has_words_before()
      local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    opts = require "astrocore".extend_tbl(opts, {
      -- Configure window style
      window = {
        completion = {
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:None",
          border = "none",
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Show type of current item at the end
          local kind = require "lspkind".cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimetry = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      },
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
    return opts
  end,
}
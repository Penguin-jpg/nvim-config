local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  "Saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  opts_extend = { "sources.default", "cmdline.sources", "term.sources" },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {},
    },
    snippets = { preset = "luasnip" },
    keymap = {
      ["<C-h>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-n>"] = { "select_next", "show" },
      ["<C-p>"] = { "select_prev", "show" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-c>"] = { "hide", "fallback" },
      ["<Esc>"] = { "hide", "fallback" },
      ["<Tab>"] = { "accept", "fallback" },
      ["<C-j>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
        end,
        "fallback",
      },
      ["<C-k>"] = {
        "select_prev",
        "snippet_backward",
        function(cmp)
          if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
        end,
        "fallback",
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
      kind_icons = require("utils.ui").get_kind_icons(),
    },
    completion = {
      list = { selection = { preselect = true, auto_insert = true } },
      menu = {
        auto_show = function(ctx) return ctx.mode ~= "cmdline" end,
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          treesitter = { "lsp" },
          columns = { { "label", gap = 1 }, { "kind_icon" }, { "kind" } },
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
        -- disable AstroLSP signature help if `blink.cmp` is providing it
        local blink_opts = require("utils.plugins").get_opts "blink.cmp"
        if vim.tbl_get(blink_opts, "signature", "enabled") == true then
          if not opts.features then opts.features = {} end
          opts.features.signature_help = false
        end
      end,
    },
  },
}

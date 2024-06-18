return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "bash", "markdown", "markdown_inline", "regex", "vim" }
      )
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local noice_opts = require("astrocore").plugin_opts "noice.nvim"
      -- disable the necessary handlers in AstroLSP
      if not opts.lsp_handlers then opts.lsp_handlers = {} end
      if vim.tbl_get(noice_opts, "lsp", "hover", "enabled") ~= false then
        opts.lsp_handlers["textDocument/hover"] = false
      end
      if vim.tbl_get(noice_opts, "lsp", "signature", "enabled") ~= false then
        opts.lsp_handlers["textDocument/signatureHelp"] = false
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          progress = { enabled = false },
          hover = { enabled = false },
          signature = { enabled = false },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        routes = {
          -- disable "written" notification
          {
            filter = { event = "msg_show", kind = "", find = "written" },
            opts = { skip = true },
          },
          -- disable paste/undo notification
          {
            filter = { event = "msg_show", find = "^%d+ more lines" },
            opts = { skip = true },
          },
          -- disable delete/undo notification
          {
            filter = { event = "msg_show", find = "^%d+ fewer lines" },
            opts = { skip = true },
          },
          -- disable yank notification
          {
            filter = { event = "msg_show", find = "^%d+ lines yanked$" },
            opts = { skip = true },
          },
          -- disable move notification
          {
            filter = { event = "msg_show", find = "^%d+ lines moved$" },
          },
        },
      })
    end,
  },
}

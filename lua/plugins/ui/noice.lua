return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = { enabled = true },
      hover = { enabled = false },
      signature = { enabled = false },
    },
    messages = {
      -- disable search count vitrual text
      view_search = false,
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
  },
}

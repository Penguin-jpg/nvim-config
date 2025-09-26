return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  dependencies = { "nvim-mini/mini.icons" },
  opts = {
    skip_confirm_for_simple_edits = true,
    columns = { "permissions", "size", "icon" },
    keymaps = {
      ["l"] = "actions.select",
      ["h"] = "actions.parent",
      ["q"] = "actions.close",
      ["?"] = "actions.show_help",
      ["yp"] = "actions.yank_entry",
      ["<\\>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<|>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-l>"] = "actions.refresh",
      ["<C-s>"] = false,
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- create autocommands for oil
    vim.api.nvim_create_augroup("oil_settings", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Disable view saving for Oil buffers",
      group = "oil_settings",
      pattern = "oil",
      callback = function(args) vim.b[args.buf].view_activated = false end,
    })
    vim.api.nvim_create_autocmd("User", {
      desc = "Close buffers when files are deleted in Oil",
      pattern = "OilActionsPost",
      callback = function(args)
        if args.data.err then return end
        for _, action in ipairs(args.data.actions) do
          if action.type == "delete" then
            local _, path = require("oil.util").parse_url(action.url)
            local bufnr = vim.fn.bufnr(path)
            if bufnr ~= -1 then vim.api.nvim_buf_delete(bufnr, { force = true }) end
          end
        end
      end,
    })
  end,
  keys = {
    {
      "<Leader>e",
      function() require("oil").open() end,
      desc = "Open Oil",
    },
  },
}

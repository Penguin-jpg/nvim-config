return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = { ui_select = true, layout = { preset = "sidebar" } },
    },
    keys = {
      -- find
      { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
      {
        "<Leader>fC",
        function() Snacks.picker.files { dirs = { vim.fn.stdpath "config" }, desc = "Config files" } end,
        desc = "Find config file",
      },
      { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<Leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
      { "<Leader>fo", function() Snacks.picker.recent() end, desc = "Find old files" },
      { "<Leader>fa", function() Snacks.picker.autocmds() end, desc = "Find autocmds" },
      { "<Leader>fc", function() Snacks.picker.commands() end, desc = "Find commands" },
      { "<Leader>fd", function() Snacks.picker.diagnostics() end, desc = "Find diagnostics" },
      { "<Leader>fh", function() Snacks.picker.help() end, desc = "Find help pages" },
      { "<Leader>fH", function() Snacks.picker.highlights() end, desc = "Find highlights" },
      { "<Leader>fk", function() Snacks.picker.keymaps() end, desc = "Find keymaps" },
      { "<Leader>f'", function() Snacks.picker.marks() end, desc = "Find marks" },
      { "<Leader>fm", function() Snacks.picker.man() end, desc = "Find man pages" },
      { "<Leader>f<CR>", function() Snacks.picker.resume() end, desc = "Resume previous search" },
      { "<Leader>fr", function() Snacks.picker.registers() end, desc = "Find registers" },
      { "<Leader>ft", function() Snacks.picker.colorschemes() end, desc = "Find colorschemes" },
      { "<Leader>fp", function() Snacks.picker.projects() end, desc = "Find projects" },
      { "<Leader>fu", function() Snacks.picker.undo() end, desc = "Find undos" },
      { "<Leader>fl", function() require("snacks").picker.lines() end, desc = "Find lines" },
      -- Grep
      { "<Leader>fw", function() Snacks.picker.grep() end, desc = "Find words" },
      { "<Leader>fw", function() Snacks.picker.grep_word() end, desc = "Find selected words", mode = { "x" } },
      {
        "<Leader>fW",
        function() Snacks.picker.grep { hidden = true, ignored = true } end,
        desc = "Find words in all files",
      },
      -- LSP
      { "<Leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Find LSP symbols" },
      -- git
      { "<Leader>gc", function() Snacks.picker.git_log() end, desc = "Git log" },
      { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    event = "User File",
    opts = {},
    keys = {
      { "<Leader>fT", function() Snacks.picker.todo_comments() end, desc = "Find Todos" },
    },
  },
}

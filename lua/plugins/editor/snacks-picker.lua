return {
  "folke/snacks.nvim",
  opts = {
    picker = {},
  },
  keys = {
    -- find
    { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
    { "<Leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end, desc = "Find config file" },
    { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<Leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
    { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Find recent" },
    -- git
    { "<Leader>gc", function() Snacks.picker.git_log() end, desc = "Git log" },
    { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    -- Grep
    { "<Leader>fw", function() Snacks.picker.grep() end, desc = "Grep words" },
    { "<Leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep visual selection", mode = { "x" } },
    -- search
    { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Search autocmds" },
    { "<Leader>sc", function() Snacks.picker.command_history() end, desc = "Search command history" },
    { "<Leader>sC", function() Snacks.picker.commands() end, desc = "Search commands" },
    { "<Leader>sd", function() Snacks.picker.diagnostics() end, desc = "Search diagnostics" },
    { "<Leader>sh", function() Snacks.picker.help() end, desc = "Search help pages" },
    { "<Leader>sH", function() Snacks.picker.highlights() end, desc = "Search highlights" },
    { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Search keymaps" },
    { "<Leader>sl", function() Snacks.picker.loclist() end, desc = "Search location list" },
    { "<Leader>s'", function() Snacks.picker.marks() end, desc = "Search marks" },
    { "<Leader>sm", function() Snacks.picker.man() end, desc = "Search man pages" },
    { "<Leader>s<CR>", function() Snacks.picker.resume() end, desc = "Resume search" },
    { "<Leader>sr", function() Snacks.picker.registers() end, desc = "Search registers" },
    { "<Leader>sq", function() Snacks.picker.qflist() end, desc = "Search quickfix list" },
    { "<Leader>st", function() Snacks.picker.colorschemes() end, desc = "Search colorschemes" },
    { "<Leader>sp", function() Snacks.picker.projects() end, desc = "Search projects" },
    { "<Leader>su", function() Snacks.picker.undo() end, desc = "Search undos" },
    -- LSP
    { "<Leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Show LSP symbols" },
  },
}

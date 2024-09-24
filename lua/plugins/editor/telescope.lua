return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",
      lazy = true,
      build = "make",
      cond = function() return vim.fn.executable "make" == 1 end,
    },
  },
  opts = function()
    local actions = require "telescope.actions"
    local selected_icon = require("utils.ui").get_icon("misc", "Selected") .. " "

    local open_selected = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local selected = picker:get_multi_selection()
      if vim.tbl_isempty(selected) then
        actions.select_default(prompt_bufnr)
      else
        actions.close(prompt_bufnr)
        for _, file in pairs(selected) do
          if file.path then vim.cmd("edit" .. (file.lnum and " +" .. file.lnum or "") .. " " .. file.path) end
        end
      end
    end

    local open_all = function(prompt_bufnr)
      actions.select_all(prompt_bufnr)
      open_selected(prompt_bufnr)
    end

    return {
      defaults = {
        prompt_prefix = selected_icon,
        selection_caret = selected_icon,
        multi_icon = selected_icon,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<CR>"] = open_selected,
            ["<A-CR>"] = open_all,
          },
          n = {
            q = actions.close,
            ["<CR>"] = open_selected,
            ["<A-CR>"] = open_all,
          },
        },
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)

    -- enable Telescope extensions if they are installed
    pcall(telescope.load_extension "fzf")
    pcall(telescope.load_extension "notify")
  end,
  keys = {
    {
      "<Leader>f'",
      function() require("telescope.builtin").marks() end,
      mode = { "n" },
      desc = "Find marks",
    },
    {
      "<Leader>f/",
      function() require("telescope.builtin").current_buffer_fuzzy_find() end,
      mode = { "n" },
      desc = "Find words in current buffer",
    },
    {
      "<Leader>f<CR>",
      function() require("telescope.builtin").resume() end,
      mode = { "n" },
      desc = "Resume previous search",
    },
    {
      "<Leader>fb",
      function() require("telescope.builtin").buffers() end,
      mode = { "n" },
      desc = "Find buffers",
    },
    {
      "<Leader>fc",
      function() require("telescope.builtin").commands() end,
      mode = { "n" },
      desc = "Find commands",
    },
    {
      "<Leader>fC",
      function()
        require("telescope.builtin").find_files {
          prompt_title = "Config Files",
          cwd = vim.fn.stdpath "config",
          follow = true,
        }
      end,
      mode = { "n" },
      desc = "Find config files",
    },
    {
      "<Leader>fd",
      function() require("telescope.builtin").diagnostics() end,
      mode = { "n" },
      desc = "Find diagnostics",
    },

    {
      "<Leader>ff",
      function() require("telescope.builtin").find_files() end,
      mode = { "n" },
      desc = "Find files",
    },
    {
      "<Leader>fF",
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      mode = { "n" },
      desc = "Find files (including hidden)",
    },
    {
      "<Leader>fh",
      function() require("telescope.builtin").oldfiles() end,
      mode = { "n" },
      desc = "Find history",
    },
    {
      "<Leader>fk",
      function() require("telescope.builtin").keymaps() end,
      mode = { "n" },
      desc = "Find keymaps",
    },
    {
      "<Leader>fm",
      function() require("telescope.builtin").man_pages() end,
      mode = { "n" },
      desc = "Find man",
    },
    {
      "<Leader>fr",
      function() require("telescope.builtin").registers() end,
      mode = { "n" },
      desc = "Find registers",
    },
    {
      "<Leader>ft",
      function() require("telescope.builtin").colorscheme { enable_preview = true, ignore_builtins = true } end,
      mode = { "n" },
      desc = "Find themes",
    },
    {
      "<Leader>fr",
      function() require("telescope.builtin").registers() end,
      mode = { "n" },
      desc = "Find registers",
    },
    {
      "<Leader>fw",
      function() require("telescope.builtin").live_grep() end,
      mode = { "n" },
      desc = "Find words",
    },
    {
      "<Leader>fW",
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
        }
      end,
      mode = { "n" },
      desc = "Find words in all files",
    },
    {
      "<Leader>gb",
      function() require("telescope.builtin").git_branches { use_file_path = true } end,
      mode = { "n" },
      desc = "Find git branches",
    },
    {
      "<Leader>gc",
      function() require("telescope.builtin").git_commits { use_file_path = true } end,
      mode = { "n" },
      desc = "Find git commits",
    },
    {
      "<Leader>gs",
      function() require("telescope.builtin").git_status { use_file_path = true } end,
      mode = { "n" },
      desc = "Find git status",
    },
  },
}

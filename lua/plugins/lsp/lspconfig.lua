local get_icon = require("utils.ui").get_icon

return {
  "neovim/nvim-lspconfig",
  event = "User File",
  cmd = function(_, cmds)
    vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" }) -- add normal `nvim-lspconfig` commands
  end,
  specs = {
    { "AstroNvim/astrolsp", opts = {} },
  },
  dependencies = {
    {
      "mason-org/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
      version = "^1",
      dependencies = { "williamboman/mason.nvim" },
      cmd = { "LspInstall", "LspUninstall" },
      opts_extend = { "ensure_installed" },
      opts = {
        ensure_installed = {},
        -- use AstroLSP setup for mason-lspconfig
        handlers = { function(server) require("astrolsp").lsp_setup(server) end },
      },
      config = function(_, opts)
        local is_available = require("utils.plugins").is_available
        if is_available "mason-tool-installer.nvim" then opts.ensure_installed = nil end
        if is_available "astrolsp" then require("astrolsp.mason-lspconfig").register_servers() end
        require("mason-lspconfig").setup(opts)
      end,
    },
    -- {
    --   "WhoIsSethDaniel/mason-tool-installer.nvim",
    --   cmd = {
    --     "MasonToolsInstall",
    --     "MasonToolsInstallSync",
    --     "MasonToolsUpdate",
    --     "MasonToolsUpdateSync",
    --     "MasonToolsClean",
    --   },
    --   opts = {
    --     ensure_installed = {
    --       -- lua
    --       "lua-language-server",
    --       "stylua",
    --       "selene",
    --       -- c/cpp
    --       "clangd",
    --       "clang-format",
    --       "codelldb",
    --       -- python
    --       "ruff",
    --       "basedpyright",
    --       "debugpy",
    --       -- json
    --       "json-lsp",
    --       -- markdown
    --       "marksman",
    --       "prettierd",
    --     },
    --   },
    --   config = function(_, opts)
    --     local mason_tool_installer = require "mason-tool-installer"
    --     mason_tool_installer.setup(opts)
    --     if opts.run_on_start ~= false then mason_tool_installer.run_on_start() end
    --   end,
    -- },
  },
  config = function()
    -- options for vim.diagnostic.config()
    local diagnostics_opts = {
      underline = true,
      update_in_insert = false,
      virtual_text = true,
      virtual_lines = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = get_icon("DiagnosticError", 1),
          [vim.diagnostic.severity.WARN] = get_icon("DiagnosticWarn", 1),
          [vim.diagnostic.severity.HINT] = get_icon("DiagnosticHint", 1),
          [vim.diagnostic.severity.INFO] = get_icon("DiagnosticInfo", 1),
        },
      },
    }
    -- config diagnostic
    vim.diagnostic.config(vim.deepcopy(diagnostics_opts))
    -- set up servers configured with AstroLSP
    vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)

    local autocmd_utils = require "utils.autocmds"
    local plugin_utils = require "utils.plugins"
    -- setup LSP servers
    local function setup_servers()
      local was_setup, astrolsp = {}, require "astrolsp"
      for _, server in ipairs(astrolsp.config.servers) do
        if not was_setup[server] then
          astrolsp.lsp_setup(server)
          was_setup[server] = true
        end
      end
      autocmd_utils.exec_buffer_autocmds("FileType", { pattern = "lspconfig" })
    end

    if plugin_utils.is_available "mason-lspconfig.nvim" then
      plugin_utils.on_load("mason-lspconfig.nvim", setup_servers)
    end
  end,
}

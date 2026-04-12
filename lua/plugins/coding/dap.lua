return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          { "williamboman/mason.nvim" },
          { "nvim-lua/plenary.nvim", lazy = true },
        },
        cmd = { "DapInstall", "DapUninstall" },
        opts_extend = { "ensure_installed" },
        opts = {
          automatic_installation = true,
          ensure_installed = {},
          handlers = {
            -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
            python = function() end,
          },
        },
        config = function(_, opts) require("mason-nvim-dap").setup(opts) end,
      },
      {
        "igorlfs/nvim-dap-view",
        lazy = true,
        version = "1.*",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = { virtual_text = { enabled = true } },
        config = function(_, opts)
          local dap, dap_view = require "dap", require "dap-view"
          dap_view.setup(opts)
          dap.listeners.after.event_initialized["dapview_config"] = function() dap_view.open {} end
          dap.listeners.before.event_terminated["dapview_config"] = function() dap_view.close {} end
          dap.listeners.before.event_exited["dapview_config"] = function() dap_view.close {} end

          -- configurations for languages
          for _, lang in ipairs { "c", "cpp" } do
            dap.configurations[lang] = {
              {
                type = "codelldb",
                request = "launch",
                name = "Launch file",
                program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
              },
              {
                type = "codelldb",
                request = "attach",
                name = "Attach to process",
                pid = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
              },
            }
          end
        end,
        keys = {
          { "<Leader>du", function() require("dap-view").toggle() end, desc = "Toggle debugger UI" },
          {
            "<Leader>de",
            function()
              vim.ui.input({ prompt = "Expression: " }, function(expr)
                if expr then require("dap-view").add_expr(expr) end
              end)
            end,
            desc = "Evaluate Input",
          },
        },
      },
    },
    config = function()
      local sign_define = vim.fn.sign_define
      local get_icon = require("utils.ui").get_icon
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      sign_define("DapBreakpoint", { text = get_icon "DapBreakpoint", texthl = "DiagnosticInfo" })
      sign_define("DapBreakpointCondition", { text = get_icon "DapBreakpointConditional", texthl = "DiagnosticInfo" })
      sign_define("DapBreakpointRejected", { text = get_icon "DapBreakpointRejected", texthl = "DiagnosticError" })
      sign_define("DapLogPoint", { text = get_icon "DapLogPoint", texthl = "DiagnosticInfo" })
      sign_define("DapStopped", { text = get_icon "DapStopped", texthl = "DiagnosticWarn" })

      -- setup dap config by vscode launch.json file
      local vscode = require "dap.ext.vscode"
      local json = require "plenary.json"
      vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end
    end,
    keys = {
      { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then require("dap").set_breakpoint(condition) end
          end)
        end,
        desc = "Conditional breakpoint",
      },
      { "<Leader>dc", function() require("dap").continue() end, desc = "Start/Continue" },
      { "<Leader>dC", function() require("dap").clear_breakpoints() end, desc = "Clear breakpoints" },
      { "<Leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<Leader>do", function() require("dap").step_out() end, desc = "Step out" },
      { "<Leader>dO", function() require("dap").step_over() end, desc = "Step over" },
      { "<Leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<Leader>dr", function() require("dap").restart_frame() end, desc = "Restart" },
      { "<Leader>dR", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<Leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<Leader>dq", function() require("dap").close() end, desc = "Close session" },
      { "<Leader>dQ", function() require("dap").terminate() end, desc = "Terminate session" },
      { "<Leader>dt", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<Leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<F5>", function() require("dap").continue() end, desc = "Start/Continue" },
      { "<F6>", function() require("dap").pause() end, desc = "Pause" },
      { "<F7>", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<F8>", function() require("dap").step_into() end, desc = "Step into" },
      { "<F9>", function() require("dap").step_out() end, desc = "Step out" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step over" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
    keys = {
      { "<Leader>dm", function() require("dap-python").test_method() end, desc = "Test method" },
    },
  },
}

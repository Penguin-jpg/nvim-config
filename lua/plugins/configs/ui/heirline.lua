return function(opts)
  local status = require("astroui.status")

  -- My custom statusline
  opts.statusline = {
    hl = { fg = "fg", bg = "bg" },
    -- Show mode text
    status.component.mode({
      -- enable mode text with padding as well as an icon before it
      mode_text = {
        mode_text = { padding = { left = 1, right = 1 } },
      },
      -- surround the component with a separators
      surround = {
        separator = "left",
      },
    }),
    status.component.file_info({
      filename = { fallback = "Empty" },
      filetype = false,
      file_modified = false,
      surround = {
        separator = { "", " " },
        color = "bg",
      },
    }),
    status.component.diagnostics({
      surround = {
        separator = "none",
        color = "bg",
      },
    }),
    status.component.git_branch({
      git_branch = { padding = { left = 1 } },
      surround = {
        separator = "none",
        color = "bg",
      },
    }),
    status.component.git_diff({
      padding = { left = 1 },
      surround = { 
        separator = "none",
        color = "bg",
      },
    }),
    status.component.fill(),
    status.component.cmd_info(),
    -- status.component.fill(),
    -- Show file encoding
    -- status.component.builder({
    --   {
    --     provider = "file_encoding",
    --     opts = { padding = { left = 1, right = 1 } },
    --   },
    -- }),
    status.component.lsp {
      surround = {
        color = function() return { main = "bg" } end
      }
    },
    status.component.virtual_env(),
    { 
      -- make nav section with icon border
      -- define a custom component with just a file icon
      status.component.builder({
        { provider = require("astroui").get_icon("Navigation") },
        -- add padding after icon
        padding = { right = 1 },
        -- set the icon foreground
        hl = { fg = "bg" },
        -- use the right separator and define the background color
        -- as well as the color to the left of the separator
        surround = {
          separator = "right",
          color = "nav_icon_bg",
        },
      }),
      -- add a navigation component and just display the percentage of progress in the file
      status.component.nav({
        -- add some padding for the percentage provider
        -- percentage = { padding = { left = 1 } },
        -- use no separator and define the background color
        surround = { separator = "none", color = "blank_bg" },
      }),
    },
    {
      status.component.builder({
        { provider = require("astroui").get_icon("Clock") },
        -- add padding after icon
        padding = { right = 1 },
        -- set the icon foreground
        hl = { fg = "bg" },
        -- use the right separator and define the background color
        -- as well as the color to the left of the separator
        surround = {
          separator = "right",
          color = { main = "clock_bg", left = "blank_bg" },
        },
      }),
      status.component.builder({
        {
          provider = function()
            local time = os.date("%H:%M") -- show hour and minute in 24 hour format
            ---@cast time string
            return status.utils.stylize(time, {
              padding = { left = 1, right = 1 }, -- pad the right side so it's not cramped
            })
          end,
        },
        surround = { separator = "none", color = "blank_bg" },
        update = { -- update should happen when the mode has changed as well as when the time has changed
          "User", -- We can use the User autocmd event space to tell the component when to update
          callback = vim.schedule_wrap(function(_, args)
            if -- update on user UpdateTime event and mode change
              (args.event == "User" and args.match == "UpdateTime")
            then
              vim.cmd.redrawstatus() -- redraw on update
            end
          end),
        },
      }),
    },
  }

  -- Now that we have the component, we need a timer to emit the User UpdateTime event
  vim.uv.new_timer():start( -- timer for updating the time
    (60 - tonumber(os.date("%S"))) * 1000, -- offset timer based on current seconds past the minute
    60000, -- update every 60 seconds
    vim.schedule_wrap(function()
      vim.api.nvim_exec_autocmds( -- emit our new User event
        "User",
        { pattern = "UpdateTime", modeline = false }
      )
    end)
  )

  return opts
end
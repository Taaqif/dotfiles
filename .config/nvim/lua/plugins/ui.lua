local uv = require("luv")
local Job = require("plenary.job")
local async = require("plenary.async")

---@diagnostic disable
local state = { comp_wakatime_time = "", homeDir = vim.fn.expand("~"), bad_call = false, show_full_text = true }

local get_wakatime_time = function()
  local tx, rx = async.control.channel.oneshot()
  local full_text = { "--today" }
  local short_text = { "--today", "--today-hide-categories", "true" }
  local ok, job = pcall(Job.new, Job, {
    command = state.homeDir .. "/.wakatime/wakatime-cli",
    args = short_text,
    on_exit = function(j, _)
      tx(j:result()[1] or "")
    end,
  })
  if not ok then
    if not state.bad_call then
      vim.notify("Bad WakaTime call: " .. job, "warn")
      state.bad_call = true
    end
    return ""
  end

  job:start()
  return rx()
end

-- Yield statusline value
-- https://github.com/wakatime/vim-wakatime/issues/110
local wakatime = function()
  local WAKATIME_UPDATE_INTERVAL = 60000

  if not Wakatime_routine_init then
    local timer = uv.new_timer()
    if timer == nil then
      return ""
    end
    -- Update wakatime every minute
    uv.timer_start(timer, 500, WAKATIME_UPDATE_INTERVAL, function()
      async.run(get_wakatime_time, function(time)
        state.comp_wakatime_time = time
      end)
    end)
    Wakatime_routine_init = true
  end

  return state.comp_wakatime_time
end

return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
    opts = function(_, opt)
      opt.theme = "hyper"
      opt.config.week_header = {
        enable = true,
      }
      opt.config.packages = { enable = false }
      opt.config.project = { enable = false }
      opt.config.shortcut = {
        {
          action = "Telescope find_files",
          desc = " Find file",
          icon = " ",
          key = "f",
        },
        {
          action = "Telescope oldfiles",
          desc = " Recent files",
          icon = " ",
          key = "r",
        },
        {
          action = "Telescope live_grep",
          desc = " Find text",
          icon = " ",
          key = "g",
        },
        {
          action = 'lua require("persistence").load()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        {
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
      return opt
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
        cmdline_popupmenu = {
          win_options = {
            winhighlight = { Normal = "NoiceCmdlinePopupResults", FloatBorder = "NoiceCmdlinePopupResultsBorder" },
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      opts.sections.lualine_z = {
        {
          wakatime,
          cond = function()
            return vim.g["loaded_wakatime"] == 1
          end,
          icon = "󱑎",
        },
      }
      return opts
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slope",
      },
    },
  },
}

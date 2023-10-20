local uv = require("luv")
local Job = require("plenary.job")
local async = require("plenary.async")

---@diagnostic disable
local state = { comp_wakatime_time = "", homeDir = vim.fn.expand("~") }

local get_wakatime_time = function()
  local tx, rx = async.control.channel.oneshot()
  local ok, job = pcall(Job.new, Job, {
    command = state.homeDir .. "/.wakatime/wakatime-cli",
    args = { "--today" },
    on_exit = function(j, _)
      tx(j:result()[1] or "")
    end,
  })
  if not ok then
    vim.notify("Bad WakaTime call: " .. job, "warn")
    return ""
  end

  job:start()
  return rx()
end

-- Yield statusline value
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
    opts = function(_, opt)
      opt.config.week_header = {
        enable = true,
      }
      return opt
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
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
      opts.sections.lualine_z = {
        {
          wakatime,
          cond = function()
            return vim.g["loaded_wakatime"] == 1
          end,
          icon = "󱑆",
        },
      }
      return opts
    end,
  },
}

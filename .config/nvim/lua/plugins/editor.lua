return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function()
      -- open neo-tree on startup
      if vim.fn.argc(-1) == 1 then
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          vim.cmd("Neotree toggle current")
        end
      else
        local mode = vim.api.nvim_get_mode().mode
        if mode == "i" or not vim.bo.modifiable then
          return
        end
        local opts = {
          ["bufhidden"] = "wipe",
          ["buflisted"] = false,
        }
        for opt, val in pairs(opts) do
          vim.opt_local[opt] = val
        end
        vim.cmd("Neotree toggle current")
      end
    end,
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, reveal = true })
        end,
        desc = "Explorer NeoTree",
      },
    },
    opts = {
      popup_border_style = "rounded",
      filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          never_show = {
            ".git",
          },
        },
      },
      source_selector = {
        winbar = true,
        content_layout = "center",
      },
      window = {
        position = "float",
        popup = {
          size = { width = "87%", height = "80%" },
        },
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      buffers = {
        window = {
          mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
          },
        },
      },
      git_status = {
        window = {
          mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            if vim.bo.filetype == "neo-tree" then
              local utils = require("neo-tree.utils")
              if utils.is_floating() then
                vim.cmd([[
                setlocal winhighlight=Normal:NormalFloat,FloatBorder:FloatBorder
                ]])
              end
              vim.opt_local.signcolumn = "auto"
              vim.cmd([[
                setlocal relativenumber
              ]])
            end
          end,
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")
      opts.files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-u"] = { actions.toggle_hidden },
        },
      }
      opts.grep = {
        rg_opts = "--column --line-number --hidden --no-heading --color=always --smart-case --max-columns=4096 -e",
        rg_glob = true,
        glob_flag = "--iglob",
        glob_separator = "%s%-%-",
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-u"] = { actions.toggle_hidden },
        },
      }
      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "viu", args = { "-b" } },
        { cmd = "ueberzug", args = { "layer", "--use-escape-codes", "-o", "iterm2" } },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end
      opts.previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      }
      return opts
    end,
  },
  {
    "nvim-mini/mini.hipatterns",
    opts = function()
      local hipatterns = require("mini.hipatterns")
      local function hi(group, opts)
        local c = "highlight " .. group
        for k, v in pairs(opts) do
          c = c .. " " .. k .. "=" .. v
        end
        vim.cmd(c)
      end

      hi("NonAscii", { gui = "NONE", cterm = "NONE", term = "NONE", guibg = "#444444" })

      local short_hex_color = function(_, match)
        local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
        local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
        return MiniHipatterns.compute_hex_color_group(hex, "bg")
      end

      return {
        tailwind = {
          enabled = true,
          ft = { "typescriptreact", "javascriptreact", "css", "javascript", "typescript", "html" },
          -- full: the whole css class will be highlighted
          -- compact: only the color will be highlighted
          style = "compact",
        },
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color({ priority = 2000 }),
          non_ascii = { pattern = "[\128-\255]", group = "NonAscii" },
          short_hex_color = { pattern = "#%x%x%x%f[%X]", group = short_hex_color },
        },
      }
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    "rhysd/conflict-marker.vim",
    init = function()
      vim.cmd("highlight ConflictMarkerBegin guibg=#2f7366")
      vim.cmd("highlight ConflictMarkerOurs guibg=#2e5049")
      vim.cmd("highlight ConflictMarkerTheirs guibg=#344f69")
      vim.cmd("highlight ConflictMarkerEnd guibg=#2f628e")
      vim.cmd("highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81")
    end,
  },
  {
    -- NOTE: Wezterm.exe needs to linked to wezterm in wsl for smart splits to work
    -- cd /bin && sudo ln -s /mnt/c/Program Files/WezTerm/wezterm.exe wezterm
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {},
    keys = {
      {
        "<C-S-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "resize left",
      },
      {
        "<C-S-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "resize right",
      },
      {
        "<C-S-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "resize up",
      },
      {
        "<C-S-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "resize right",
      },
      -- moving between splits
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "move left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "move down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "move up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "move right",
      },
      {
        "<leader>bh",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "swap left",
      },
      {
        "<leader>bj",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "swap down",
      },
      {
        "<leader>bk",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "swap up",
      },
      {
        "<leader>bl",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "swap right",
      },
    },
  },
}

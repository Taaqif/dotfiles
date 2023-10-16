return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
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
            vim.opt_local.signcolumn = "auto"
            vim.cmd([[
            setlocal relativenumber
            ]])
          end,
        },
      },
    },
  },
  {
    "echasnovski/mini.hipatterns",
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
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      log_level = "debug",
    },
    keys = {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "resize left",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "resize right",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "resize up",
      },
      {
        "<A-l>",
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

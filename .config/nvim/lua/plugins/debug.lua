return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      event = "BufReadPre", -- <-- this
    },
  },
  opts = function()
    local js_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local dap = require("dap")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }
    dap.adapters["node-terminal"] = {
      type = "executable",
      command = "js-debug-adapter",
    }
    dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = { vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug") },
    }
    require("dap.ext.vscode").load_launchjs(nil, {
      ["pwa-node"] = js_languages,
      ["node"] = js_languages,
      ["chrome"] = js_languages,
      ["pwa-chrome"] = js_languages,
      ["node-terminal"] = js_languages,
    })
    for _, language in ipairs(js_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach Program (pwa-chrome = { port: 9222 })",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
        {
          type = "chrome",
          request = "attach",
          name = "Attach Program (chrome = { port: 9222 })",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
        -- Divider for the launch.json derived configs
        {
          name = "----- ↓ launch.json configs (if available) ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end
  end,
}

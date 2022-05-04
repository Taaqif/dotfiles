local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {

        -- code action sources

        -- diagnostic sources

        -- formatting sources
        formatting.stylua,
        formatting.prettierd

        -- hover sources

        -- completion sources
    },
})

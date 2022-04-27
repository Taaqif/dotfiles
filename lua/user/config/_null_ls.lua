local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = true,
    sources = {

        -- code action sources
        -- null_ls.builtins.code_actions
        -- code_actions.eslint,

        -- diagnostic sources
        -- null_ls.builtins.diagnostics
        -- diagnostics.eslint,

        -- formatting sources
        -- null_ls.builtins.formatting

        -- hover sources
        -- null_ls.builtins.hover

        -- completion sources
        -- null_ls.builtins.completion
    },
})

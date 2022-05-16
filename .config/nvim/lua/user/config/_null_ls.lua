local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local completion = null_ls.builtins.completion
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {

        -- code action sources
        -- completion.spell,
        -- diagnostic sources
        -- diagnostics.cspell.with({
        --     diagnostics_postprocess = function(diagnostic)
        --         diagnostic.severity = vim.diagnostic.severity["INFO"]
        --     end,
        -- }),
        -- formatting sources
        formatting.stylua,
        formatting.prettierd

        -- hover sources

        -- completion sources
    },
})

local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
local _, lspconfig = pcall(require, "lspconfig")
return {
  setup = function(opts)
    if rust_tools_ok then
      rust_tools.setup({
        server = opts,
      })
    else
      lspconfig["rust_analyzer"].setup(opts)
    end
  end,
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
    -- Code action groups
    vim.keymap.set("n", "<Leader>lA", rust_tools.code_action_group.code_action_group, { buffer = bufnr, desc = "Rust code action" })
  end,
}

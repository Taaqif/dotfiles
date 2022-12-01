
local glance_ok, glance = pcall(require, "glance")

if not glance_ok then
	return
end

local actions = glance.actions

glance.setup({
  hooks = {
  before_open = function(results, open, jump, method)
    local uri = vim.uri_from_bufnr(0)
    if #results == 1 then
      local target_uri = results[1].uri or results[1].targetUri

      if target_uri == uri then
        jump(results[1])
      else
        open(results)
      end
    else
      open(results)
    end
  end,
}
})

vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')

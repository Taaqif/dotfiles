local ok, notify = pcall(require, "notify")

if not ok then
  return
end

notify.setup({
  level = "info",
  stages = "fade_in_slide_out",
})
vim.notify = notify


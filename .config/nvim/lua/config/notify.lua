local ok, notify = pcall(require, "notify")

if not ok then
  return
end

notify.setup({
  level = "info",
  stages = "fade_in_slide_out",
  background_colour = "#282A36"
})
vim.notify = notify


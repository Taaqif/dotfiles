local opt = vim.opt

vim.g.trouble_lualine = false
opt.scrolloff = 8
opt.showbreak = "↪ "
opt.wrap = true
opt.spelloptions = "camel"
opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -noprofile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -noprofile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
opt.list = true
opt.listchars = {
  eol = "↵",
  tab = "» ",
  trail = "·",
  space = "·",
  nbsp = "␣",
}

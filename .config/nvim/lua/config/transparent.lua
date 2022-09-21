local ok, transparent = pcall(require, "transparent")

if not ok then
  return
end

transparent.setup({
  enable = false, 
  extra_groups = { 
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude = {
  }, 
})

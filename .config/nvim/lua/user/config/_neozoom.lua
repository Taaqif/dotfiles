local ok, neo_zoom = pcall(require, "neo-zoom")

if not ok then
  return
end

neo_zoom.setup { -- use the defaults or UNCOMMENT and change any one to overwrite
-- left_ratio = 0.2,
-- top_ratio = 0.03,
-- width_ratio = 0.67,
-- height_ratio = 0.9
    }
vim.keymap.set('n', '<CR>', function ()
vim.cmd('NeoZoomToggle')
    end, NOREF_NOERR_TRUNC)

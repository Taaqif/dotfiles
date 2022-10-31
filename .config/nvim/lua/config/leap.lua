
local ok, leap = pcall(require, "leap")

if not ok then
  return
end

leap.add_default_mappings()
-- vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
-- vim.api.nvim_set_hl(0, 'LeapMatch', {
--   fg = 'white',  -- for light themes, set to 'black' or similar
--   bold = true,
--   nocombine = true,
-- })
-- leap.opts.highlight_unlabeled_phase_one_targets = true

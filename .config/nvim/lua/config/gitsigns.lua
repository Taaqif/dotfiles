local ok, gitsigns = pcall(require, "gitsigns")

if not ok then
    return
end


gitsigns.setup {
    signs = {
        add = { hl = 'GitSignsAdd', text = '▎' },
        change = { hl = 'GitSignsChange', text = '▎' },
        delete = { hl = 'GitSignsDelete', text = '契' },
        topdelete = { hl = 'GitSignsDelete', text = '契' },
        changedelete = { hl = 'GitSignsChange', text = '▎' },
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
    current_line_blame = false,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}

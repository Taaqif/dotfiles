local window_picker_ok, window_picker = pcall(require, "window-picker")
if not window_picker_ok then
	return
end
window_picker.setup({ use_winbar = "smart" })

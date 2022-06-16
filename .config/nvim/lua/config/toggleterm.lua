local ok, toggleterm = pcall(require, "toggleterm")

if not ok then
    return
end


toggleterm.setup{
	open_mapping = [[<c-\>]],
	direction = "float",
	shell = "pwsh.exe -NoLogo",
	float_opts = {
		border = "curved",
	},
}

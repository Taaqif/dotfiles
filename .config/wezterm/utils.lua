local wezterm = require("wezterm")
local M = {}

function M.basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function M.merge_tables(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			M.merge_tables(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
	return t1
end

function M.merge_lists(t1, t2)
	local result = {}
	for _, v in pairs(t1) do
		table.insert(result, v)
	end
	for _, v in pairs(t2) do
		table.insert(result, v)
	end
	return result
end

function M.exists(tab, element)
	for _, v in pairs(tab) do
		if v == element then
			return true
		elseif type(v) == "table" then
			return M.exists(v, element)
		end
	end
	return false
end

function M.convert_home_dir(path)
	local cwd = path
	local home = os.getenv("HOME")
	cwd = cwd:gsub("^" .. home .. "/", "~/")
	if cwd == "" then
		return path
	end
	return cwd
end

function M.file_exists(fname)
	local stat = vim.loop.fs_stat(vim.fn.expand(fname))
	return (stat and stat.type) or false
end

function M.convert_useful_path(dir)
	local cwd = M.convert_home_dir(dir)
	return M.basename(cwd)
end

function M.split_from_url(cwd_uri)
	local cwd = ""
	local hostname = ""
	if type(cwd_uri) == "userdata" then
		-- Running on a newer version of wezterm and we have
		-- a URL object here, making this simple!

		cwd = cwd_uri.file_path
		hostname = cwd_uri.host or wezterm.hostname()
	else
		-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
		-- which doesn't have the Url object
		cwd_uri = cwd_uri:sub(8)
		local slash = cwd_uri:find("/")
		if slash then
			hostname = cwd_uri:sub(1, slash - 1)
			-- and extract the cwd from the uri, decoding %-encoding
			cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
				return string.char(tonumber(hex, 16))
			end)
		end
	end
	-- Remove the domain name portion of the hostname
	local dot = hostname:find("[.]")
	if dot then
		hostname = hostname:sub(1, dot - 1)
	end
	if hostname == "" then
		hostname = wezterm.hostname()
	end

	return hostname, cwd
end

M.icons = {
	CLOSE = "",
	MAXIMIZE = "󰁌",
	HIDE = "",
	NEW = "",
	SOLID_LEFT_ARROW = "",
	SOLID_LEFT_MOST = "█",
	SOLID_RIGHT_ARROW = "",
	ZOOM = "󰘖",
	COPY = "󰕢",
	VIM = "",
	SUP_IDX = {
		"¹",
		"²",
		"³",
		"⁴",
		"⁵",
		"⁶",
		"⁷",
		"⁸",
		"⁹",
		"¹⁰",
		"¹¹",
		"¹²",
		"¹³",
		"¹⁴",
		"¹⁵",
		"¹⁶",
		"¹⁷",
		"¹⁸",
		"¹⁹",
		"²⁰",
	},
	SUB_IDX = {
		"₁",
		"₂",
		"₃",
		"₄",
		"₅",
		"₆",
		"₇",
		"₈",
		"₉",
		"₁₀",
		"₁₁",
		"₁₂",
		"₁₃",
		"₁₄",
		"₁₅",
		"₁₆",
		"₁₇",
		"₁₈",
		"₁₉",
		"₂₀",
	},
}

return M

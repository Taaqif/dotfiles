local lualine_ok, lualine = pcall(require, "lualine")

-- vim.api.nvim_create_autocmd({ "TextYankPost" }, {
--   callback = function()
--     vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
--   end,
-- })
--
--
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- highlight non ascii characters
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	command = [[syntax match NonAscii "[^\u0000-\u007F]"]],
})

if lualine_ok then
	vim.api.nvim_create_autocmd("RecordingEnter", {
		callback = function()
      local lualine_ok, lualine = pcall(require, "lualine")
			lualine.refresh({
				place = { "statusline" },
			})
		end,
	})

	vim.api.nvim_create_autocmd("RecordingLeave", {
		callback = function()
			-- This is going to seem really weird!
			-- Instead of just calling refresh we need to wait a moment because of the nature of
			-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
			-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
			-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
			-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
			local timer = vim.loop.new_timer()
			timer:start(
				50,
				0,
				vim.schedule_wrap(function()
					lualine.refresh({
						place = { "statusline" },
					})
				end)
			)
		end,
	})
end


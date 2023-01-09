return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	init = function()
		-- TODO: https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
	end,
	event = "VeryLazy",
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		local icons = require("icons")
		local dap_breakpoint = {
			breakpoint = {
				text = icons.ui.BigUnfilledCircle,
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			},
			breakpoint_rejected = {
				text = icons.ui.BigUnfilledCircle,
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			},
			stopped = {
				text = icons.ui.BoldArrowRight,
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			},
			log_point = {
				text = icons.ui.ChevronRightDot,
				texthl = "DiagnosticInfo",
				linehl = "",
				numhl = "",
			},
		}

		vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
		vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
		vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.breakpoint_rejected)
		vim.fn.sign_define("DapLogPoint", dap_breakpoint.log_point)

		dapui.setup({})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}

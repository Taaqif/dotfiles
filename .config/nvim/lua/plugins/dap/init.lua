return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	init = function()

		local wk = require("which-key")
		wk.register({
			["<leader>D"] = { name = "DAP" },
		})

		local map = vim.keymap.set
		map("n", "<F5>", function()
			require("dap").continue()
		end, { desc = "Debugger: Start" })
		map("n", "<F17>", function()
			require("dap").terminate()
		end, { desc = "Debugger: Stop" })
		map("n", "<F29>", function()
			require("dap").restart_frame()
		end, { desc = "Debugger: Restart" })
		map("n", "<F6>", function()
			require("dap").pause()
		end, { desc = "Debugger: Pause" })
		map("n", "<F9>", function()
			require("dap").toggle_breakpoint()
		end, { desc = "Debugger: Toggle Breakpoint" })
		map("n", "<F10>", function()
			require("dap").step_over()
		end, { desc = "Debugger: Step Over" })
		map("n", "<F11>", function()
			require("dap").step_into()
		end, { desc = "Debugger: Step Into" })
		map("n", "<F23>", function()
			require("dap").step_out()
		end, { desc = "Debugger: Step Out" })
		map("n", "<leader>Db", function()
			require("dap").toggle_breakpoint()
		end, { desc = "Toggle Breakpoint (F9)" })
		map("n", "<leader>DB", function()
			require("dap").clear_breakpoints()
		end, { desc = "Clear Breakpoints" })
		map("n", "<leader>Dc", function()
			require("dap").continue()
		end, { desc = "Start/Continue (F5)" })
		map("n", "<leader>Di", function()
			require("dap").step_into()
		end, { desc = "Step Into (F11)" })
		map("n", "<leader>Do", function()
			require("dap").step_over()
		end, { desc = "Step Over (F10)" })
		map("n", "<leader>DO", function()
			require("dap").step_out()
		end, { desc = "Step Out (S-F11)" })
		map("n", "<leader>Dq", function()
			require("dap").close()
		end, { desc = "Close Session" })
		map("n", "<leader>DQ", function()
			require("dap").terminate()
		end, { desc = "Terminate Session (S-F5)" })
		map("n", "<leader>Dp", function()
			require("dap").pause()
		end, { desc = "Pause (F6)" })
		map("n", "<leader>Dr", function()
			require("dap").restart_frame()
		end, { desc = "Restart (C-F5)" })
		map("n", "<leader>DR", function()
			require("dap").repl.toggle()
		end, { desc = "Toggle REPL" })
		map("n", "<leader>Du", function()
			require("dapui").toggle()
		end, { desc = "Toggle Debugger UI" })
		map("n", "<leader>Dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Debugger Hover" })
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

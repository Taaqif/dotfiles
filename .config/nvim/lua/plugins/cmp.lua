local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"dmitmel/cmp-cmdline-history",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
		"rafamadriz/friendly-snippets",

		"L3MON4D3/LuaSnip",
	},
	event = "InsertEnter",
	config = function()
		vim.o.completeopt = "menu,menuone,noselect"
		vim.opt.shortmess = vim.opt.shortmess + { c = true }
		vim.api.nvim_set_option("updatetime", 300)
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local icons = require("icons")
		local luasnip = require("luasnip")

		luasnip.setup({
			region_check_events = "CursorHold,InsertLeave,InsertEnter",
			delete_check_events = "TextChanged,InsertEnter,InsertLeave",
		})

		luasnip.filetype_extend("typescript", { "javascript" })
		luasnip.filetype_extend("typescriptreact", { "javascript" })
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
		cmp.setup({
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "emoji" },
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					symbol_map = icons.kind,
					before = function(entry, vim_item) -- for tailwind css autocomplete
						if vim_item.kind == "Color" and entry.completion_item.documentation then
							local _, _, r, g, b =
								string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
							if r then
								local color = string.format("%02x", r)
									.. string.format("%02x", g)
									.. string.format("%02x", b)
								local group = "Tw_" .. color
								if vim.fn.hlID(group) < 1 then
									vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
								end
								vim_item.kind_hl_group = group
								return vim_item
							end
						end
						return vim_item
					end,
				}),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -6,
				},
				documentation = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				},
			},
			mapping = {
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<Up>"] = cmp.mapping.select_prev_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_prev_item(),
				["<Down>"] = cmp.mapping.select_next_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_next_item(),
				["<C-f>"] = cmp.mapping.scroll_docs(5),
				["<C-u>"] = cmp.mapping.scroll_docs(-5),
				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-d>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- go to previous placeholder in the snippet
				["<C-b>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
		})
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			mapping = cmp.mapping.preset.cmdline(),
		})
		cmp.setup.cmdline("/", {
			sources = {
				{ name = "nvim_lsp_document_symbol" },
				{ name = "buffer" },
			},
			mapping = cmp.mapping.preset.cmdline(),
		})
	end,
}

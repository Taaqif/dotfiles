local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
local lspkind_ok, lspkind = pcall(require, "lspkind")
if not cmp_ok or not luasnip_ok or not lspkind_ok then
	return
end
local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local icons = require("config.icons")

if luasnip_ok then
	luasnip.setup({
		region_check_events = "CursorHold,InsertLeave,InsertEnter",
		delete_check_events = "TextChanged,InsertEnter",
	})

	luasnip.filetype_extend("typescript", { "javascript" })
	luasnip.filetype_extend("typescriptreact", { "javascript" })
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
end

vim.opt.completeopt = "menu,menuone,noselect"

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			symbol_map = icons.kind,
		}),
	},
	-- window = {
	--     completion = {
	--         border = border "CmpBorder",
	--     },
	--     documentation = {
	--         border = border "CmpDocBorder",
	--     },
	-- },
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	-- Sources order are actually their priority order
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "emoji" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.close(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
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
	}),
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

-- init.lua (Minimal Neovim Configuration)

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Indentation width
vim.opt.tabstop = 2 -- Tab width
vim.opt.smartindent = true -- Smart indentation
vim.opt.wrap = true -- Enable line wrapping
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- System clipboard integration
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Case-sensitive if uppercase is used
vim.opt.hlsearch = true -- Enable search highlight
vim.opt.incsearch = true -- Incremental search
vim.opt.termguicolors = true -- Enable true color support
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.cursorline = true -- Highlight current line
vim.opt.modeline = true -- Enable modelines
vim.opt.fillchars:append({ eob = " " }) -- Hide end-of-buffer (~) characters

-- Keybindings
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true }) -- ESC cancels search highlight
vim.keymap.set("n", "<leader>-", ":split<CR>", { noremap = true, silent = true }) -- Split window below
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { noremap = true, silent = true }) -- Split window right
vim.keymap.set("n", "<leader>qq", ":qall<CR>", { noremap = true, silent = true }) -- Quit Neovim
vim.keymap.set("n", "<S-l>", ":tabnext<CR>", { noremap = true, silent = true }) -- Go to right tab
vim.keymap.set("n", "<S-h>", ":tabprevious<CR>", { noremap = true, silent = true }) -- Go to left tab
vim.keymap.set("n", "<leader>fn", ":tabnew<CR>:ene<CR>", { noremap = true, silent = true }) -- New file in a new tab
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- Move to left split
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- Move to below split
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- Move to above split
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- Move to right split
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true }) -- respect wrapped lines on j/k
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true }) -- respect wrapped lines on j/k

-- Close the current buffer; quit Nevoim if it's the last buffer
vim.keymap.set("n", "<leader>bd", function()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	if #bufs > 1 then
		vim.cmd("bdelete")
	else
		vim.cmd("quit")
	end
end, { noremap = true, silent = true })

-- Toggle line wrap
vim.keymap.set("n", "<leader>uw", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { noremap = true, silent = true, desc = "Toggle Line Wrap" })

-- Toggle absolute line numbers
vim.keymap.set("n", "<leader>ul", function()
	vim.opt.number = not vim.opt.number:get()
end, { noremap = true, silent = true, desc = "Toggle Line Numbers" })

-- Toggle relative line numbers
vim.keymap.set("n", "<leader>uL", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true, desc = "Toggle Relative Line Numbers" })

-- Function to toggle Netrw
local function toggle_netrw(command)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			vim.api.nvim_win_close(win, true) -- Close Netrw if open
			return
		end
	end
	vim.cmd("leftabove 30vsplit | " .. command) -- Open Netrw in left split
end

-- Toggle Netrw in a left split
vim.keymap.set("n", "<leader>e", function()
	toggle_netrw("Explore")
end, { noremap = true, silent = true }) -- Root dir
vim.keymap.set("n", "<leader>E", function()
	toggle_netrw("Lexplore")
end, { noremap = true, silent = true }) -- CWD

-- Basic statusline
vim.opt.laststatus = 2
vim.opt.statusline = "%f %y %m %= %p%% [%l:%c]"

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Catppuccin Mocha-like colorscheme (manually configured)
vim.cmd("highlight Normal guibg=#1E1E2E guifg=#CDD6F4")
vim.cmd("highlight Comment guifg=#6C7086")
vim.cmd("highlight LineNr guifg=#6C7086")
vim.cmd("highlight CursorLineNr guifg=#F5E0DC gui=bold")
vim.cmd("highlight StatusLine guibg=#1E1E2E guifg=#A6ADC8 gui=bold")
vim.cmd("highlight Visual guibg=#45475A")
vim.cmd("highlight Pmenu guibg=#181825 guifg=#CDD6F4")
vim.cmd("highlight PmenuSel guibg=#45475A guifg=#A6ADC8")
vim.cmd("highlight CursorLine guibg=#2A2A37") -- Highlight current line subtly

-- Netrw improvements
vim.g.netrw_browse_split = 3 -- Open files in a new tab
vim.g.netrw_altv = 1 -- Open splits to the right
vim.g.netrw_winsize = 25 -- Set Netrw window size
vim.g.netrw_banner = 0 -- Hide the banner
vim.g.netrw_liststyle = 3 -- Tree view
vim.cmd("highlight netrwDir guifg=#89B4FA gui=bold") -- Highlight directories
vim.cmd("highlight netrwClassify guifg=#FAB387") -- Highlight file classifications
vim.cmd("highlight netrwExe guifg=#A6E3A1") -- Highlight executables
vim.cmd("highlight netrwSymLink guifg=#F5E0DC") -- Highlight symlinks

-- Load fzf-lua
local fzf_lua_path = vim.fn.stdpath("config") .. "/lua/fzf-lua"
if vim.loop.fs_stat(fzf_lua_path .. "/fzf-lua.lua") then
	package.path = fzf_lua_path .. "/?.lua;" .. fzf_lua_path .. "/?/init.lua;" .. package.path
	require("fzf-lua").setup({})
end

-- Keymaps for fzf-lua
-- Show all files in the root directory
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files({ winopts = { title = " Files " } })
end, { noremap = true, silent = true })

-- Show all files in the root directory
vim.keymap.set("n", "<leader> ", function()
	require("fzf-lua").files({ winopts = { title = " Files " } })
end, { noremap = true, silent = true })

-- Show all files in the current working directory
vim.keymap.set("n", "<leader>fF", function()
	require("fzf-lua").files({
		cwd = vim.fn.getcwd(), -- Use the current working directory
		winopts = { title = " Files (CWD) " },
	})
end, { noremap = true, silent = true })

-- Grep in the root dir
vim.keymap.set("n", "<leader>/", function()
	require("fzf-lua").live_grep({ winopts = { title = " Grep " } })
end, { noremap = true, silent = true })

-- Show all open buffers
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers({ winopts = { title = " Buffers " } })
end, { noremap = true, silent = true })

-- Show Neovim config files
vim.keymap.set("n", "<leader>fc", function()
	require("fzf-lua").files({
		cwd = vim.fn.stdpath("config"), -- Get the Neovim config directory dynamically
		winopts = { title = " Config Files " },
	})
end, { noremap = true, silent = true })

-- Show recent files (global)
vim.keymap.set("n", "<leader>fr", function()
	require("fzf-lua").oldfiles({
		winopts = { title = " Oldfiles " },
	})
end, { noremap = true, silent = true })

-- Show recent files in the current working directory
vim.keymap.set("n", "<leader>fR", function()
	require("fzf-lua").oldfiles({
		cwd = vim.fn.getcwd(), -- Limit to current working directory
		winopts = { title = " Oldfiles (CWD)" },
	})
end, { noremap = true, silent = true })

-- Grep in open buffers
vim.keymap.set("n", "<leader>sb", function()
	require("fzf-lua").grep_curbuf({
		winopts = { title = " Buffer Grep " },
	})
end, { noremap = true, silent = true })

-- Show command history
vim.keymap.set("n", "<leader>sc", function()
	require("fzf-lua").command_history({
		winopts = { title = " Command History " },
	})
end, { noremap = true, silent = true })

-- Show all available commands
vim.keymap.set("n", "<leader>sC", function()
	require("fzf-lua").commands({
		winopts = { title = " Commands " },
	})
end, { noremap = true, silent = true })

-- Grep in root directory
vim.keymap.set("n", "<leader>sg", function()
	require("fzf-lua").live_grep({
		cwd = vim.fn.getcwd(), -- Root directory
		winopts = { title = " Grep (Root) " },
	})
end, { noremap = true, silent = true })

-- Grep in current working directory
vim.keymap.set("n", "<leader>sG", function()
	require("fzf-lua").live_grep({
		cwd = vim.fn.expand("%:p:h"), -- Current file's directory
		winopts = { title = " Grep (CWD) " },
	})
end, { noremap = true, silent = true })

-- Show jumplist
vim.keymap.set("n", "<leader>sj", function()
	require("fzf-lua").jumps({
		winopts = { title = " Jumplist " },
	})
end, { noremap = true, silent = true })

-- Show keymaps
vim.keymap.set("n", "<leader>sk", function()
	require("fzf-lua").keymaps({
		winopts = { title = " Keymaps " },
	})
end, { noremap = true, silent = true })

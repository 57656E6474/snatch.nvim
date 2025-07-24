local M = {}

function M.full_path()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	-- Copy to both system clipboard (+) and default register (") so 'p' works
	local success = pcall(function()
		vim.fn.setreg('"', path) -- Also copy to default register for 'p' command
	end)

	if success then
		vim.notify("Full file path copied to clipboard: " .. path, vim.log.levels.INFO)
	else
		-- Fallback to system clipboard if + register fails
		vim.fn.setreg('"', path) -- Also copy to default register for 'p' command
		vim.notify("Full file path copied to system clipboard: " .. path, vim.log.levels.INFO)
	end
end

function M.filename()
	local filename = vim.fn.expand("%:t")
	if filename == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	-- Copy to both system clipboard (+) and default register (") so 'p' works
	local success = pcall(function()
		vim.fn.setreg('"', filename) -- Also copy to default register for 'p' command
	end)

	if success then
		vim.notify("File name copied to clipboard: " .. filename, vim.log.levels.INFO)
	else
		-- Fallback to system clipboard if + register fails
		vim.fn.setreg('"', filename) -- Also copy to default register for 'p' command
		vim.notify("File name copied to system clipboard: " .. filename, vim.log.levels.INFO)
	end
end

function M.relativeProjectRoot()
	local relative_path = vim.fn.expand("%:~:.")
	if relative_path == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	-- Copy to both system clipboard (+) and default register (") so 'p' works
	local success = pcall(function()
		vim.fn.setreg('"', relative_path) -- Also copy to default register for 'p' command
	end)

	if success then
		vim.notify("Relative file path copied to clipboard: " .. relative_path, vim.log.levels.INFO)
	else
		-- Fallback to system clipboard if + register fails
		vim.fn.setreg('"', relative_path) -- Also copy to default register for 'p' command
		vim.notify("Relative file path copied to system clipboard: " .. relative_path, vim.log.levels.INFO)
	end
end

function M.setup(config)
	if not config then
		config = {}
	end

	-- Default keymaps
	local keymaps = config.keymaps or {
		full_path = "<leader>cp",
		filename = "<leader>cf",
		relative_path = "<leader>cr"
	}

	-- Set up keymaps
	vim.keymap.set("n", keymaps.full_path, M.full_path, {
		silent = true,
		noremap = true,
		desc = "Snatch the full file path"
	})
	vim.keymap.set("n", keymaps.filename, M.filename, {
		silent = true,
		noremap = true,
		desc = "Snatch the file name"
	})
	vim.keymap.set("n", keymaps.relative_path, M.relativeProjectRoot, {
		silent = true,
		noremap = true,
		desc = "Snatch the relative file path from project root"
	})
end

-- Create user commands
vim.api.nvim_create_user_command("SnatchFullPath", M.full_path, { desc = "Snatch the full file path" })
vim.api.nvim_create_user_command("SnatchFileName", M.filename, { desc = "Snatch the file name" })
vim.api.nvim_create_user_command("SnatchRelativePath", M.relativeProjectRoot, { desc = "Snatch the relative file path" })

-- Auto-setup with default config
M.setup()

return M

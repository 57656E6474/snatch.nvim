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

function M.relativeWorkingDir()
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

function M.relativeGitRoot()
	local git_root = vim.fn.system("git rev-parse --show-toplevel")
	git_root = vim.trim(git_root) -- Remove trailing newline
	if git_root == "" then
		vim.notify("Not inside a Git repository", vim.log.levels.WARN)
		return nil
	end

	local full_path = vim.fn.expand("%:p")
	if full_path == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return nil
	end

	-- Use a simpler approach to get relative path
	local relative_path = string.gsub(full_path, "^" .. git_root .. "/", "")
	if relative_path == "" then
		vim.notify("Could not determine relative path from Git root", vim.log.levels.WARN)
		return nil
	end

	-- Copy to both system clipboard (+) and default register (") so 'p' works
	local success = pcall(function()
		vim.fn.setreg('"', relative_path) -- Also copy to default register for 'p' command
	end)

	if success then
		vim.notify("Relative file path from Git root copied to clipboard: " .. relative_path, vim.log.levels.INFO)
	else
		-- Fallback to system clipboard if + register fails
		vim.fn.setreg('"', relative_path) -- Also copy to default register for 'p' command
		vim.notify("Relative file path from Git root copied to system clipboard: " .. relative_path, vim.log.levels.INFO)
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
		relative_path = "<leader>cr",
		git_root = "<leader>cg"
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
	vim.keymap.set("n", keymaps.relative_path, M.relativeWorkingDir, {
		silent = true,
		noremap = true,
		desc = "Snatch the relative file path from working directory"
	})

	vim.keymap.set("n", keymaps.git_root, M.relativeGitRoot, {
		silent = true,
		noremap = true,
		desc = "Snatch the relative file path from Git root"
	})
end

-- Create user commands
vim.api.nvim_create_user_command("SnatchFullPath", M.full_path, { desc = "Snatch the full file path" })
vim.api.nvim_create_user_command("SnatchFileName", M.filename, { desc = "Snatch the file name" })
vim.api.nvim_create_user_command("SnatchRelativePath", M.relativeWorkingDir, { desc = "Snatch the relative file path from working directory" })
vim.api.nvim_create_user_command("SnatchRelativeGitRoot", M.relativeGitRoot,
	{ desc = "Snatch the relative file path from Git root" })

-- Auto-setup with default config
M.setup()

return M

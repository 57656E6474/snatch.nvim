local M = {}

function M.full_path()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	vim.fn.setreg("+", path)
	vim.notify("Full file path copied to clipboard", vim.log.levels.INFO)
end

function M.filename()
	local filename = vim.fn.expand("%:t")
	if filename == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	vim.fn.setreg("+", filename)
	vim.notify("File name copied to clipboard", vim.log.levels.INFO)
end

function M.setup(config)
	if not config then
		config = {}
	end

	vim.keymap.set("n", config.keymaps.full_path, M.full_path, {
		desc = "Snatch the full file path"
	})
	vim.keymap.set("n", "<leader>cf", config.keymaps.filename, {
		desc = "Snatch the file name"
	})
end

vim.api.nvim_create_user_command("SnatchFullPath", M.full_path, { desc = "Snatch the full file path" })
vim.api.nvim_create_user_command("SnatchFileName", M.filename, { desc = "Snatch the file name" })

M.setup()

return M

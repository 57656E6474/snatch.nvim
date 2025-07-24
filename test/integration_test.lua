-- Integration test for snatch.nvim
print("Running snatch.nvim integration tests...")

-- Load plugin
local snatch = require('snatch')

-- Test functions exist
local functions = {
  'full_path',
  'filename',
  'relativeWorkingDir',
  'relativeGitRoot',
  'setup'
}

for _, func in ipairs(functions) do
  if snatch[func] then
    print("✓ " .. func .. " function exists")
  else
    print("✗ " .. func .. " function missing")
  end
end

-- Test commands exist
local commands = vim.api.nvim_get_commands({})
local expected_commands = {
  "SnatchFullPath",
  "SnatchFileName",
  "SnatchRelativePath",
  "SnatchRelativeGitRoot"
}

for _, cmd in ipairs(expected_commands) do
  if commands[cmd] then
    print("✓ " .. cmd .. " command exists")
  else
    print("✗ " .. cmd .. " command missing")
  end
end

print("Integration tests completed!")

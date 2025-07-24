-- Test file for snatch.nvim
package.path = package.path .. ";lua/?.lua;lua/?/init.lua"

-- Mock vim
_G.vim = {
  fn = {
    expand = function() return "" end,
    setreg = function() end,
    system = function() return "" end,
    trim = function(str) return str:gsub("\n$", "") end
  },
  notify = function() end,
  log = { levels = { WARN = 2, INFO = 3 } },
  api = { nvim_create_user_command = function() end },
  keymap = { set = function() end }
}

local snatch = require('snatch')

describe('snatch.nvim', function()
  describe('full_path()', function()
    it('should copy full file path', function()
      -- Test that function exists
      assert.is_not_nil(snatch.full_path)
      assert.is_function(snatch.full_path)
    end)
  end)

  describe('filename()', function()
    it('should copy filename', function()
      -- Test that function exists
      assert.is_not_nil(snatch.filename)
      assert.is_function(snatch.filename)
    end)
  end)

  describe('relativeWorkingDir()', function()
    it('should copy relative path from working directory', function()
      -- Test that function exists
      assert.is_not_nil(snatch.relativeWorkingDir)
      assert.is_function(snatch.relativeWorkingDir)
    end)
  end)

  describe('relativeGitRoot()', function()
    it('should copy relative path from git root', function()
      -- Test that function exists
      assert.is_not_nil(snatch.relativeGitRoot)
      assert.is_function(snatch.relativeGitRoot)
    end)
  end)

  describe('setup()', function()
    it('should have setup function', function()
      -- Test that function exists
      assert.is_not_nil(snatch.setup)
      assert.is_function(snatch.setup)
    end)

    it('should set up all keymaps', function()
      -- Mock keymap.set
      local keymap_calls = {}
      _G.vim.keymap.set = function(mode, lhs, rhs, opts)
        table.insert(keymap_calls, {mode = mode, lhs = lhs, rhs = rhs, opts = opts})
      end

      -- Call setup
      snatch.setup()

      -- Should set up 4 keymaps
      assert.equals(4, #keymap_calls)

      -- Check that all expected keymaps are set
      local expected_keymaps = {"<leader>cp", "<leader>cf", "<leader>cr", "<leader>cg"}
      for _, expected in ipairs(expected_keymaps) do
        local found = false
        for _, call in ipairs(keymap_calls) do
          if call.lhs == expected then
            found = true
            break
          end
        end
        assert.is_true(found, "Keymap " .. expected .. " should be set")
      end
    end)
  end)
end)

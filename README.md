# snatch.nvim

A sneaky Neovim plugin to snatch file info and stash it in your clipboard like a ninja. 🥷

## Features

- **Copy full file path** - Get the absolute path of the current file
- **Copy filename only** - Get just the filename without the path
- **Copy relative path** - Get the path relative to your home directory
- **Smart notifications** - Get feedback when operations succeed or fail
- **Customizable keymaps** - Configure your own keybindings
- **User commands** - Use commands like `:SnatchFullPath`, `:SnatchFileName`, and `:SnatchRelativePath`

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "ralph/snatch.nvim",
  config = function()
    require("snatch").setup({
      keymaps = {
        full_path = "<leader>cp",     -- Copy full path
        filename = "<leader>cf",      -- Copy filename
        relative_path = "<leader>cr"  -- Copy relative path
      }
    })
  end
}
```
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "ralph/snatch.nvim",
  config = function()
    require("snatch").setup({
      keymaps = {
        full_path = "<leader>cp",
        filename = "<leader>cf",
        relative_path = "<leader>cr"
      }
    })
  end
}
```
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'ralph/snatch.nvim'
```

Then add to your init.lua or init.vim:
```lua
require("snatch").setup({
  keymaps = {
    full_path = "<leader>cp",
    filename = "<leader>cf",
    relative_path = "<leader>cr"
  }
})
```

## Usage

### Keymaps (Default)

- `<leader>cp` - Copy the full file path to clipboard
- `<leader>cf` - Copy just the filename to clipboard
- `<leader>cr` - Copy the relative file path to clipboard

### Commands

- `:SnatchFullPath` - Copy the full file path to clipboard
- `:SnatchFileName` - Copy just the filename to clipboard
- `:SnatchRelativePath` - Copy the relative file path to clipboard

### Examples

If you have a file open at `/home/user/projects/myapp/src/main.lua`:

- Using `<leader>cp` will copy: `/home/user/projects/myapp/src/main.lua`
- Using `<leader>cf` will copy: `main.lua`
- Using `<leader>cr` will copy: `~/projects/myapp/src/main.lua`

## Configuration

You can customize the keymaps by passing a config table to the setup function:

```lua
require("snatch").setup({
  keymaps = {
    full_path = "<leader>cp",     -- Default: <leader>cp
    filename = "<leader>cf",      -- Default: <leader>cf
    relative_path = "<leader>cr"  -- Default: <leader>cr
  }
})
```

## Requirements

- Neovim 0.8.0 or higher
- A clipboard provider (like `clipboard=unnamedplus` or `clipboard=unnamed`)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to open issues or submit pull requests to improve this plugin!

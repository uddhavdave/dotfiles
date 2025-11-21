# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Configuration

This is a Neovim configuration based on LazyVim, a modern Neovim distribution. The configuration uses the lazy.nvim plugin manager and follows LazyVim's conventions.

## Architecture

- **Entry Point**: `init.lua` - Bootstraps lazy.nvim and loads the configuration
- **Plugin Manager**: Uses lazy.nvim with automatic plugin loading from the `plugins/` directory
- **Configuration Structure**:
  - `lua/config/` - Core configuration files (options, keymaps, autocmds)
  - `lua/plugins/` - Custom plugin specifications that extend LazyVim defaults
  - Plugin files return Lua tables that configure or override LazyVim plugins

## Key Customizations

- **Colorscheme**: Catppuccin Mocha theme with extensive integration support
- **Rust Development**: Enhanced rust-analyzer configuration with clippy integration
- **Code Formatting**: StyLua configured for 2-space indentation, 120 column width

## Plugin Management Commands

- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install missing plugins and update existing ones
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for updates

## Code Formatting

- **Lua files**: Use StyLua with 2-space indentation and 120 column width
- Format command: `:lua vim.lsp.buf.format()`

## Development Workflow

1. LazyVim automatically installs and manages LSP servers via Mason
2. Plugin configurations in `lua/plugins/` are automatically loaded by lazy.nvim
3. The configuration follows LazyVim's lazy-loading approach for performance
4. Custom plugins should be added as separate files in the `plugins/` directory

## File Patterns

- Plugin files should return a Lua table with plugin specifications
- Use lazy.nvim's plugin spec format: `{ "plugin/name", opts = {...} }`
- Override existing LazyVim plugins by specifying the same plugin name with new options
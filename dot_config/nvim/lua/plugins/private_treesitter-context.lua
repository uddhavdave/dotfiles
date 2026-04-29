-- Enable LazyVim's treesitter-context extra
return {
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  -- Customize the treesitter-context settings
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 5, -- Increase from default 3 to 5 lines
      mode = "cursor", -- Use cursor position for context
      separator = "-", -- Add a separator line
    },
  },
}

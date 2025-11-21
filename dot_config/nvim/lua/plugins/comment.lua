return {
  "numToStr/Comment.nvim",
  keys = {
    { "<C-/>", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "Toggle comment line" },
    { "<C-/>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = "v", desc = "Toggle comment selection" },
    { "gc", mode = { "n", "v" }, desc = "Toggle comment" },
    { "gcc", mode = "n", desc = "Toggle comment line" },
    { "gbc", mode = "n", desc = "Toggle comment block" },
  },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    })
  end,
}
return {
  {
    "swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = function()
      if vim.fn.filereadable("/.dockerenv") == 1 then
        -- Docker: no zellij CLI, use plain vim window nav (lock Zellij with Ctrl-g first)
        return {
          { "<c-h>", "<C-w>h", { silent = true, desc = "navigate left" } },
          { "<c-j>", "<C-w>j", { silent = true, desc = "navigate down" } },
          { "<c-k>", "<C-w>k", { silent = true, desc = "navigate up" } },
          { "<c-l>", "<C-w>l", { silent = true, desc = "navigate right" } },
        }
      else
        -- Host: full zellij integration
        return {
          { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "navigate left or tab" } },
          { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
          { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
          { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
        }
      end
    end,
    opts = {},
  },
}

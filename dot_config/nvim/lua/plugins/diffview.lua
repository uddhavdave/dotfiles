return {
  "sindrets/diffview.nvim",
  opts = {
    view = {
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
        winbar_info = true,
      },
    },
    keymaps = {
      view = {
        { "n", "[x", function() require("diffview.actions").prev_conflict() end, { desc = "Previous conflict" } },
        { "n", "]x", function() require("diffview.actions").next_conflict() end, { desc = "Next conflict" } },
        { "n", "<leader>co", function() require("diffview.actions").conflict_choose("ours") end, { desc = "Choose ours" } },
        { "n", "<leader>ct", function() require("diffview.actions").conflict_choose("theirs") end, { desc = "Choose theirs" } },
        { "n", "<leader>cb", function() require("diffview.actions").conflict_choose("base") end, { desc = "Choose base" } },
        { "n", "<leader>ca", function() require("diffview.actions").conflict_choose("all") end, { desc = "Choose all" } },
        { "n", "dx", function() require("diffview.actions").conflict_choose("none") end, { desc = "Delete conflict" } },
      },
    },
  },
}
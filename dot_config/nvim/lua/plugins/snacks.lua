return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<C-`>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
    },
    opts = {
      terminal = {
        win = {
          position = "float",
        },
      },
    },
  },
}